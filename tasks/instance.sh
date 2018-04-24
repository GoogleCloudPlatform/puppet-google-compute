#!/bin/bash
# Copyright 2018 Google Inc.
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
declare -r ruby='/opt/puppetlabs/puppet/bin/ruby'

declare -r parser=$(cat <<EOF
require 'json'
require 'timeout'

begin
  Timeout::timeout(3) do
    puts JSON.parse(STDIN.read).to_json
  end
rescue Timeout::Error
  puts({ status: 'failure', error: "Couldn't read from stdin" }.to_json)
rescue Exception => e
  puts({ status: 'failure', error: e.message }.to_json)
end
EOF
)

declare -r input="$(${ruby} -e "${parser}")"
declare -r run_log="$(mktemp /tmp/bolt-run-XXXXXX)"

if [[ $input =~ status.*failure ]]; then
  echo "${input}"
  exit 1
fi

declare puppet_args
[[ $BOLT_VERBOSE -ne 1 ]] || puppet_args="${puppet_args} --verbose"
[[ $BOLT_DEBUG -ne 1 ]] || puppet_args="${puppet_args} --debug"
readonly puppet_args

trap "rm '${run_log}'" TERM EXIT

$puppet apply ${puppet_args} 1>${run_log} 2>&1 <<EOF
# Because sometimes you just want a quick way to get (or destroy) an instance
#
# Command line arguments: JSON object from STDIN with the following fields:
#
# - name: Name of the machine to create (or delete) (default: bolt-<random>)
# - image_family: An indication of which image family to launch the instance from (format: <familyname>:<organization>) (default: centos-7:centos-cloud)
# - size_gb: The size of the VM disk (in GB) (default: 50)
# - machine_type: The type of the machine to create (default: n1-standard-1)
# - allocate_static_ip: If true it will allocate a static IP for the machine (default: false)
# - network_name: The network to connect the VM to (default: default)
# - zone: The zone where your instance resides (default: us-west1-c)
# - project: The project you have credentials for and will houses your instance
# - credential: Path to a service account credentials file
# - ensure: If you'd wish to quickly delete an instance instead of creating one (default: present)

# Load parameters provided by task executor
\$params = gcompute_task_load_params('${input}')

# Validate and parse user input parameters
# I usually can't advocate the use to inline_template but I am trying
# hard not to require someone to install stdlib to run this task because
# the gcompute modules currently does not require it.
\$_name = gcompute_task_validate_param(
  \$params, 'name', "bolt-\${inline_template('<%= SecureRandom.hex(8) -%>')}"
)
\$image_family = gcompute_task_validate_param(
  \$params, 'image_family', 'centos-7:centos-cloud'
)
\$size_gb = gcompute_task_validate_param(\$params, 'size_gb', '50')
\$machine_type = gcompute_task_validate_param(
  \$params, 'machine_type', 'n1-standard-1'
)
\$allocate_static_ip = gcompute_task_validate_param(
  \$params, 'allocate_static_ip', 'false'
)
\$network_name = gcompute_task_validate_param(
  \$params, 'network_name', 'default'
)
\$zone = gcompute_task_validate_param(\$params, 'zone', 'us-west1-c')
\$project = gcompute_task_validate_param(\$params, 'project', '<-undef->')
\$credential = gcompute_task_validate_param(\$params, 'credential', '<-undef->')
\$ensure = gcompute_task_validate_param(\$params, 'ensure', 'present')
\$vm = \$_name
\$image = split(\$image_family, ':') # input: <family-name>:<image-name>

# Convert provided zone to a region
\$region_parts = split(\$zone, '-')
\$region       = "\${region_parts[0]}-\${region_parts[1]}"

# Convenience because title is only used by Puppet, not GCP
\$cred = 'bolt-credential'

gauth_credential { \$cred:
  provider => serviceaccount,
  path     => \$credential,
  scopes   => ['https://www.googleapis.com/auth/cloud-platform'],
}

gcompute_network { \$network_name:
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
        network        => \$network_name,
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
        network        => \$network_name,
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