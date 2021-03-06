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

# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    AUTO GENERATED CODE     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by Magic Modules and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in README.md and
#     CONTRIBUTING.md located at the root of this package.
#
# ----------------------------------------------------------------------------

require 'google/compute/property/integer'
require 'google/compute/property/namevalues'
require 'google/compute/property/region_name'
require 'google/compute/property/router_selflink'
require 'google/compute/property/string'
require 'google/compute/property/string_array'
require 'google/compute/property/targetvpngateway_selflink'
require 'google/compute/property/time'
require 'google/object_store'
require 'puppet'

Puppet::Type.newtype(:gcompute_vpn_tunnel) do
  @doc = 'VPN tunnel resource.'

  autorequire(:gauth_credential) do
    credential = self[:credential]
    raise "#{ref}: required property 'credential' is missing" if credential.nil?
    [credential]
  end

  autorequire(:gcompute_region) do
    reference = self[:region]
    raise "#{ref} required property 'region' is missing" if reference.nil?
    reference.autorequires
  end

  ensurable

  newparam :credential do
    desc <<-DESC
      A gauth_credential name to be used to authenticate with Google Cloud
      Platform.
    DESC
  end

  newparam(:project) do
    desc 'A Google Cloud Platform project to manage.'
  end

  newparam(:name, namevar: true) do
    # TODO(nelsona): Make this description to match the key of the object.
    desc 'The name of the VpnTunnel.'
  end

  newparam(:region, parent: Google::Compute::Property::RegionNameRef) do
    desc 'The region where the tunnel is located.'
  end

  newproperty(:creation_timestamp, parent: Google::Compute::Property::Time) do
    desc 'Creation timestamp in RFC3339 text format. (output only)'
  end

  newproperty(:name, parent: Google::Compute::Property::String) do
    desc <<-DOC
      Name of the resource. The name must be 1-63 characters long, and comply with RFC1035.
      Specifically, the name must be 1-63 characters long and match the regular expression
      `[a-z]([-a-z0-9]*[a-z0-9])?` which means the first character must be a lowercase letter, and
      all following characters must be a dash, lowercase letter, or digit, except the last
      character, which cannot be a dash.
    DOC
  end

  newproperty(:description, parent: Google::Compute::Property::String) do
    desc 'An optional description of this resource.'
  end

  newproperty(:target_vpn_gateway,
              parent: Google::Compute::Property::TargetVpnGatewaySelfLinkRef) do
    desc 'URL of the Target VPN gateway with which this VPN tunnel is associated.'
  end

  newproperty(:router, parent: Google::Compute::Property::RouterSelfLinkRef) do
    desc 'URL of router resource to be used for dynamic routing.'
  end

  newproperty(:peer_ip, parent: Google::Compute::Property::String) do
    desc 'IP address of the peer VPN gateway. Only IPv4 is supported.'
  end

  newproperty(:shared_secret, parent: Google::Compute::Property::String) do
    desc <<-DOC
      Shared secret used to set the secure session between the Cloud VPN gateway and the peer VPN
      gateway.
    DOC
  end

  newproperty(:shared_secret_hash, parent: Google::Compute::Property::String) do
    desc 'Hash of the shared secret. (output only)'
  end

  newproperty(:ike_version, parent: Google::Compute::Property::Integer) do
    desc <<-DOC
      IKE protocol version to use when establishing the VPN tunnel with peer VPN gateway.
      Acceptable IKE versions are 1 or 2. Default version is 2.
    DOC
    defaultto 2
  end

  newproperty(:local_traffic_selector, parent: Google::Compute::Property::StringArray) do
    desc <<-DOC
      Local traffic selector to use when establishing the VPN tunnel with peer VPN gateway. The
      value should be a CIDR formatted string, for example `192.168.0.0/16`. The ranges should be
      disjoint. Only IPv4 is supported.
    DOC
  end

  newproperty(:remote_traffic_selector, parent: Google::Compute::Property::StringArray) do
    desc <<-DOC
      Remote traffic selector to use when establishing the VPN tunnel with peer VPN gateway. The
      value should be a CIDR formatted string, for example `192.168.0.0/16`. The ranges should be
      disjoint. Only IPv4 is supported.
    DOC
  end

  newproperty(:labels, parent: Google::Compute::Property::NameValues) do
    desc 'Labels to apply to this VpnTunnel.'
  end

  newproperty(:label_fingerprint, parent: Google::Compute::Property::String) do
    desc <<-DOC
      The fingerprint used for optimistic locking of this resource. Used internally during updates.
      (output only)
    DOC
  end

  # Returns all properties that a provider can export to other resources
  def exports
    provider.exports
  end
end
