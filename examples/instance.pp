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

# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    AUTO GENERATED CODE     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by puppet-codegen and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in README.md and
#     CONTRIBUTING.md located at the root of this package.
#
# ----------------------------------------------------------------------------

# Defines a credential to be used when communicating with Google Cloud
# Platform. The title of this credential is then used as the 'credential'
# parameter in the gdns_managed_zone type.
#
# For more information on the gauth_credential parameters and providers please
# refer to its detailed documentation at:
#
#   https://forge.puppet.com/google/gauth
#
# For the sake of this example we set the parameter 'path' to point to the file
# that contains your credential in JSON format. And for convenience this example
# allows a variable named $cred_path to be provided to it. If running from the
# command line you can pass it via Facter:
#
#   FACTER_cred_path=/path/to/my/cred.json \
#       puppet apply examples/instance.pp
#
# For convenience you optionally can add it to your ~/.bash_profile (or the
# respective .profile settings) environment:
#
#   export FACTER_cred_path=/path/to/my/cred.json
#
gauth_credential { 'mycred':
  path     => $cred_path, # e.g. '/home/nelsonjr/my_account.json'
  provider => serviceaccount,
  scopes   => [
    'https://www.googleapis.com/auth/compute',
  ],
}

gcompute_zone { 'us-central1-a':
  project    => 'google.com:graphite-playground',
  credential => 'mycred',
}

gcompute_disk { 'instance-test-os-1':
  ensure       => present,
  size_gb      => 50,
  source_image =>
    'projects/ubuntu-os-cloud/global/images/family/ubuntu-1604-lts',
  zone         => 'us-central1-a',
  project      => 'google.com:graphite-playground',
  credential   => 'mycred',
}

# Tips
#   1) You can use network 'default' if do not use VLAN or other traffic
#      seggregation on your project.
#   2) Don't forget to define the firewall rules if you specify a custom
#      network to ensure the traffic can reach your machine
gcompute_network { 'default':
  ensure     => present,
  project    => 'google.com:graphite-playground',
  credential => 'mycred',
}

gcompute_region { 'us-central1':
  project    => 'google.com:graphite-playground',
  credential => 'mycred',
}

# Defines the machine type to be used by the VM. This definition is required
# only once per catalog as it is shared to any objects that use the
# 'n1-standard-1' defined below.
gcompute_machine_type { 'n1-standard-1':
  zone       => 'us-central1-a',
  project    => 'google.com:graphite-playground',
  credential => 'mycred',
}

# Ensures the 'instance-test-ip' external IP address exists. If it does not
# exist it will allocate an ephemeral one.
gcompute_address { 'instance-test-ip':
  region     => 'us-central1',
  project    => 'google.com:graphite-playground',
  credential => 'mycred',
}

gcompute_instance { 'instance-test':
  ensure             => present,
  machine_type       => 'n1-standard-1',
  disks              => [
    {
      auto_delete => true,
      boot        => true,
      source      => 'instance-test-os-1'
    }
  ],
  metadata => {
    'startup-script-url' =>
      'gs://graphite-production/public/bootstrap-sample.sh',
    'cost-center'        => '12345',
  },
  network_interfaces => [
    {
      network        => 'default',
      access_configs => [
        {
          name   => 'External NAT',
          nat_ip => 'instance-test-ip',
          type   => 'ONE_TO_ONE_NAT',
        },
      ],
    }
  ],
  zone               => 'us-central1-a',
  project            => 'google.com:graphite-playground',
  credential         => 'mycred',
}
