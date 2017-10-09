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

require 'google/compute/property/integer'
require 'google/compute/property/network_selflink'
require 'google/compute/property/string'
require 'google/compute/property/string_array'
require 'puppet'

Puppet::Type.newtype(:gcompute_route) do
  @doc = <<-DOC
    Represents a Route resource. A route is a rule that specifies how certain
    packets should be handled by the virtual network. Routes are associated
    with virtual machines by tag, and the set of routes for a particular
    virtual machine is called its routing table. For each packet leaving a
    virtual machine, the system searches that virtual machine's routing table
    for a single best matching route. Routes match packets by destination IP
    address, preferring smaller or more specific ranges over larger ones. If
    there is a tie, the system selects the route with the smallest priority
    value. If there is still a tie, it uses the layer three and four packet
    headers to select just one of the remaining matching routes. The packet is
    then forwarded as specified by the next_hop field of the winning route --
    either to another virtual machine destination, a virtual machine gateway or
    a Compute Engine-operated gateway. Packets that do not match any route in
    the sending virtual machine's routing table will be dropped. A Routes
    resources must have exactly one specification of either nextHopGateway,
    nextHopInstance, nextHopIp, or nextHopVpnTunnel.
  DOC

  autorequire(:gauth_credential) do
    credential = self[:credential]
    fail "#{self.ref}: required property 'credential' is missing" \
      if credential.nil?
    [credential]
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
    desc 'The name of the Route.'
  end

  newproperty(:dest_range, parent: Google::Compute::Property::String) do
    desc <<-DOC
      The destination range of outgoing packets that this route applies to.
      Only IPv4 is supported.
    DOC
  end

  newproperty(:name, parent: Google::Compute::Property::String) do
    desc <<-DOC
      Name of the resource. Provided by the client when the resource is
      created. The name must be 1-63 characters long, and comply with RFC1035.
      Specifically, the name must be 1-63 characters long and match the regular
      expression [a-z]([-a-z0-9]*[a-z0-9])? which means the first character
      must be a lowercase letter, and all following characters must be a dash,
      lowercase letter, or digit, except the last character, which cannot be a
      dash.
    DOC
  end

  newproperty(:network, parent: Google::Compute::Property::NetwoSelfLinkRef) do
    desc 'A reference to Network resource'
  end

  newproperty(:priority, parent: Google::Compute::Property::Integer) do
    desc <<-DOC
      The priority of this route. Priority is used to break ties in cases where
      there is more than one matching route of equal prefix length. In the case
      of two routes with equal prefix length, the one with the lowest-numbered
      priority value wins. Default value is 1000. Valid range is 0 through
      65535.
    DOC
  end

  newproperty(:tags, parent: Google::Compute::Property::StringArray) do
    desc 'A list of instance tags to which this route applies.'
  end

  newproperty(:next_hop_gateway, parent: Google::Compute::Property::String) do
    desc <<-DOC
      URL to a gateway that should handle matching packets. Currently, you can
      only specify the internet gateway, using a full or partial valid URL: *
      https://www.googleapis.com/compute/v1/projects/project/
      global/gateways/default-internet-gateway *
      projects/project/global/gateways/default-internet-gateway *
      global/gateways/default-internet-gateway
    DOC
  end

  newproperty(:next_hop_instance, parent: Google::Compute::Property::String) do
    desc <<-DOC
      URL to an instance that should handle matching packets. You can specify
      this as a full or partial URL. For example: *
      https://www.googleapis.com/compute/v1/projects/project/zones/zone/
      instances/instance * projects/project/zones/zone/instances/instance *
      zones/zone/instances/instance
    DOC
  end

  newproperty(:next_hop_ip, parent: Google::Compute::Property::String) do
    desc <<-DOC
      Network IP address of an instance that should handle matching packets.
    DOC
  end

  newproperty(:next_hop_vpn_tunnel,
              parent: Google::Compute::Property::String) do
    desc 'URL to a VpnTunnel that should handle matching packets.'
  end
end
