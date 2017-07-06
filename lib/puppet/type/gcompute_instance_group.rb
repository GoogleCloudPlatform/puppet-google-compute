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

require 'google/compute/property/instancegroup_named_ports'
require 'google/compute/property/integer'
require 'google/compute/property/network_selflink'
require 'google/compute/property/region_selflink'
require 'google/compute/property/string'
require 'google/compute/property/subnetwork_selflink'
require 'google/compute/property/time'
require 'google/object_store'
require 'puppet'

Puppet::Type.newtype(:gcompute_instance_group) do
  @doc = <<-EOT
    Represents an Instance Group resource. Instance groups are self-managed and
    can contain identical or different instances. Instance groups do not use an
    instance template. Unlike managed instance groups, you must create and add
    instances to an instance group manually.
  EOT

  autorequire(:gauth_credential) do
    [self[:credential]]
  end

  ensurable

  newparam :credential do
    desc <<-EOT
      A gauth_credential name to be used to authenticate with Google Cloud
      Platform.
    EOT
  end

  newparam(:project) do
    desc 'A Google Cloud Platform project to manage.'
  end

  newparam(:name, namevar: true) do
    # TODO(nelsona): Make this description to match the key of the object.
    desc 'The name of the InstanceGroup.'
  end

  newparam(:zone, parent: Google::Compute::Property::String) do
    desc 'URL of the zone where the autoscaler resides.'
  end

  newproperty(:creation_timestamp, parent: Google::Compute::Property::Time) do
    desc 'Creation timestamp in RFC3339 text format. (output only)'
  end

  newproperty(:description, parent: Google::Compute::Property::String) do
    desc <<-EOT
      An optional description of this resource. Provide this property when you
      create the resource.
    EOT
  end

  newproperty(:id, parent: Google::Compute::Property::Integer) do
    desc 'A unique identifier for this instance group. (output only)'
  end

  newproperty(:name, parent: Google::Compute::Property::String) do
    desc <<-EOT
      The name of the instance group. The name must be 1-63 characters long,
      and comply with RFC1035.
    EOT
  end

  newproperty(:named_ports,
              parent: Google::Compute::Property::InstaGroupNamedPortsArray) do
    desc <<-EOT
      Assigns a name to a port number. For example: {name: "http", port: 80}.
      This allows the system to reference ports by the assigned name instead of
      a port number. Named ports can also contain multiple ports. For example:
      [{name: "http", port: 80},{name: "http", port: 8080}] Named ports apply
      to all instances in this instance group.
    EOT
  end

  newproperty(:network, parent: Google::Compute::Property::NetwoSelfLinkRef) do
    desc 'A reference to Network resource'
  end

  newproperty(:region, parent: Google::Compute::Property::RegioSelfLinkRef) do
    desc 'A reference to Region resource'
  end

  newproperty(:subnetwork,
              parent: Google::Compute::Property::SubneSelfLinkRef) do
    desc 'A reference to Subnetwork resource'
  end

  # Returns all properties that a provider can export to other resources
  def exports
    provider.exports
  end
end