#!/bin/bash
# Copyright 2017 Google Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

declare -r puppet='/opt/puppetlabs/bin/puppet'
declare -r input="$(python -m json.tool | tr -d "\n")"
declare -r run_log="$(mktemp /tmp/bolt-run-XXXXXX)"

declare puppet_args
[[ $BOLT_VERBOSE -ne 1 ]] || puppet_args='--debug'
readonly puppet_args

trap "rm '${run_log}'" TERM EXIT

$puppet apply ${puppet_args} 1>${run_log} 2>&1 <<EOF
# Creates (or deletes) a Google Compute Engine VM instance
#
# Command line arguments: JSON object from STDIN with the following fields:
#
# - name: the name of the instance to create (or delete)
# - zone: the zone where the instance will be located
# - project: the Google Cloud Project where the VM instance is hosted
# - credential: the path for the Service Account JSON credential file

# Load parameters provided by task executor
\$params = gcompute_task_load_params('${input}')

# Set paramters to some local variables to make changing parameter names easier
\$credpath = \$params['credential']
\$project  = \$params['project']

# Set some defaults if they were not provided by the task executor
\$ensure   = \$params['ensure'] ? {
  undef   => present,
  default => \$params['ensure'],
}
\$machine_type  = \$params['machine_type'] ? {
  undef        => 'n1-standard-1',
  default      => \$params['machine_type'],
}
\$size_gb  = \$params['size_gb'] ? {
  undef   => 50,
  default => \$params['size_gb'],
}
\$netname  = \$params['network'] ? {
  undef   => 'default',
  default => \$params['network'],
}
\$zone     = \$params['zone'] ? {
  undef   => 'us-west1-c',
  default => \$params['zone'],
}
\$image    = \$params['image_family'] ? {
  undef   => ['centos-7', 'centos-cloud'],
  default => split(\$params['image_family']),
}
\$allocate_static_ip  = \$params['allocate_static_ip'] ? {
  undef              => false, # not all workloads require a static IP address
  default            => \$params['allocate_static_ip'],
}
# I usually can't advocate the use to inline_template but I am trying hard not
# to require someone to install stdlib to run this task because the gcompute
# modules currently does not require it.
\$vm       = \$params['name'] ? {
  undef   => "bolt-\${inline_template('<%= SecureRandom.hex(8) -%>')}",
  default => \$params['name'],
}

# Convert provided zone to a region
\$region_parts = split(\$zone, '-')
\$region       = "\${region_parts[0]}-\${region_parts[1]}"

# Convenience because title is only used by Puppet, not GCP
\$cred = 'bolt-credential'

gauth_credential { \$cred:
  provider => serviceaccount,
  path     => \$credpath,
  scopes   => ['https://www.googleapis.com/auth/cloud-platform'],
}

gcompute_network { \$netname:
  project    => \$project,
  credential => \$cred,
}

gcompute_region { \$region:
  project    => \$project,
  credential => \$cred,
}

gcompute_zone { \$zone:
  project    => \$project,
  credential => \$cred,
}

gcompute_machine_type { \$machine_type:
  zone       => \$zone,
  project    => \$project,
  credential => \$cred,
}

if \$ensure == absent {
  Gcompute_instance[\$vm] -> Gcompute_disk[\$vm]
  if \$allocate_static_ip {
    Gcompute_instance[\$vm] -> Gcompute_address[\$vm]
  }
}

gcompute_disk { \$vm:
  ensure       => \$ensure,
  size_gb      => \$size_gb,
  source_image => gcompute_image_family(\$image[0], \$image[1]),
  zone         => \$zone,
  project      => \$project,
  credential   => \$cred,
}

if \$allocate_static_ip {
  gcompute_address { \$vm:
    ensure     => \$ensure,
    region     => \$region,
    project    => \$project,
    credential => \$cred,
  }

  gcompute_instance { \$vm:
    ensure             => \$ensure,
    machine_type       => \$machine_type,
    disks              => [
      {
        boot        => true,
        source      => \$vm,
        auto_delete => true,
      }
    ],
    network_interfaces => [
      {
        network        => \$netname,
        access_configs => [
          {
            name   => 'External NAT',
            nat_ip => \$vm,
            type   => 'ONE_TO_ONE_NAT',
          }
        ],
      }
    ],
    zone               => \$zone,
    project            => \$project,
    credential         => \$cred,
  }
} else {
  gcompute_instance { \$vm:
    ensure             => \$ensure,
    machine_type       => \$machine_type,
    disks              => [
      {
        boot        => true,
        source      => \$vm,
        auto_delete => true,
      }
    ],
    network_interfaces => [
      {
        network        => \$netname,
        access_configs => [
          {
            name   => 'External NAT',
            type   => 'ONE_TO_ONE_NAT',
          }
        ],
      }
    ],
    zone               => \$zone,
    project            => \$project,
    credential         => \$cred,
  }
}

notify { 'task:success':
  message => "\$vm",
  require => Gcompute_instance[\$vm],
}
EOF

declare -r success_line=$(grep 'Notice:.*task:success.*define.*as' "${run_log}")
if [[ ! -z ${success_line} ]]; then
  declare -r vm_name=$(sed -e "s/.* as '\(.*\)'.*/\1/" <<< ${success_line})
  echo "{ \"status\": \"success\", \"name\": \"${vm_name}\" }"
  exit 0
else
  echo "{ \"status\": \"failure\" }"
  [[ $BOLT_VERBOSE -ne 1 ]] || cat "${run_log}"
  exit 1
fi
