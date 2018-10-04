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

require 'google/compute/property/boolean'
require 'google/compute/property/enum'
require 'google/compute/property/firewall_allowed'
require 'google/compute/property/firewall_denied'
require 'google/compute/property/integer'
require 'google/compute/property/network_selflink'
require 'google/compute/property/string'
require 'google/compute/property/string_array'
require 'google/compute/property/time'
require 'google/object_store'
require 'puppet'

Puppet::Type.newtype(:gcompute_firewall) do
  @doc = <<-DOC
    Each network has its own firewall controlling access to and from the instances. All traffic to
    instances, even from other instances, is blocked by the firewall unless firewall rules are
    created to allow it. The default network has automatically created firewall rules that are
    shown in default firewall rules. No manually created network has automatically created firewall
    rules except for a default "allow" rule for outgoing traffic and a default "deny" for incoming
    traffic. For all networks except the default network, you must create any firewall rules you
    need.
  DOC

  autorequire(:gauth_credential) do
    credential = self[:credential]
    raise "#{ref}: required property 'credential' is missing" if credential.nil?
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
    desc 'The name of the Firewall.'
  end

  newproperty(:allowed, parent: Google::Compute::Property::FirewallAllowedArray) do
    desc <<-DOC
      The list of ALLOW rules specified by this firewall. Each rule specifies a protocol and
      port-range tuple that describes a permitted connection.
    DOC
  end

  newproperty(:creation_timestamp, parent: Google::Compute::Property::Time) do
    desc 'Creation timestamp in RFC3339 text format. (output only)'
  end

  newproperty(:denied, parent: Google::Compute::Property::FirewallDeniedArray) do
    desc <<-DOC
      The list of DENY rules specified by this firewall. Each rule specifies a protocol and
      port-range tuple that describes a denied connection.
    DOC
  end

  newproperty(:description, parent: Google::Compute::Property::String) do
    desc <<-DOC
      An optional description of this resource. Provide this property when you create the resource.
    DOC
  end

  newproperty(:destination_ranges, parent: Google::Compute::Property::StringArray) do
    desc <<-DOC
      If destination ranges are specified, the firewall will apply only to traffic that has
      destination IP address in these ranges. These ranges must be expressed in CIDR format. Only
      IPv4 is supported.
    DOC
  end

  newproperty(:direction, parent: Google::Compute::Property::Enum) do
    desc <<-DOC
      Direction of traffic to which this firewall applies; default is INGRESS. Note: For INGRESS
      traffic, it is NOT supported to specify destinationRanges; For EGRESS traffic, it is NOT
      supported to specify sourceRanges OR sourceTags.
    DOC
    newvalue(:INGRESS)
    newvalue(:EGRESS)
  end

  newproperty(:disabled, parent: Google::Compute::Property::Boolean) do
    desc <<-DOC
      Denotes whether the firewall rule is disabled, i.e not applied to the network it is
      associated with. When set to true, the firewall rule is not enforced and the network behaves
      as if it did not exist. If this is unspecified, the firewall rule will be enabled.
    DOC
    newvalue(:true)
    newvalue(:false)
  end

  newproperty(:id, parent: Google::Compute::Property::Integer) do
    desc 'The unique identifier for the resource. (output only)'
  end

  newproperty(:name, parent: Google::Compute::Property::String) do
    desc <<-DOC
      Name of the resource. Provided by the client when the resource is created. The name must be
      1-63 characters long, and comply with RFC1035. Specifically, the name must be 1-63 characters
      long and match the regular expression `[a-z]([-a-z0-9]*[a-z0-9])?` which means the first
      character must be a lowercase letter, and all following characters must be a dash, lowercase
      letter, or digit, except the last character, which cannot be a dash.
    DOC
  end

  newproperty(:network, parent: Google::Compute::Property::NetworkSelfLinkRef) do
    desc <<-DOC
      URL of the network resource for this firewall rule. If not specified when creating a firewall
      rule, the default network is used:  global/networks/default If you choose to specify this
      property, you can specify the network as a full or partial URL. For example, the following
      are all valid URLs:  https://www.googleapis.com/compute/v1/projects/myproject/global/
      networks/my-network  projects/myproject/global/networks/my-network  global/networks/default
    DOC
  end

  newproperty(:priority, parent: Google::Compute::Property::Integer) do
    desc <<-DOC
      Priority for this rule. This is an integer between 0 and 65535, both inclusive. When not
      specified, the value assumed is 1000. Relative priorities determine precedence of conflicting
      rules. Lower value of priority implies higher precedence (eg, a rule with priority 0 has
      higher precedence than a rule with priority 1). DENY rules take precedence over ALLOW rules
      having equal priority.
    DOC
    defaultto 1000
  end

  newproperty(:source_ranges, parent: Google::Compute::Property::StringArray) do
    desc <<-DOC
      If source ranges are specified, the firewall will apply only to traffic that has source IP
      address in these ranges. These ranges must be expressed in CIDR format. One or both of
      sourceRanges and sourceTags may be set. If both properties are set, the firewall will apply
      to traffic that has source IP address within sourceRanges OR the source IP that belongs to a
      tag listed in the sourceTags property. The connection does not need to match both properties
      for the firewall to apply. Only IPv4 is supported.
    DOC
  end

  newproperty(:source_service_accounts, parent: Google::Compute::Property::StringArray) do
    desc <<-DOC
      If source service accounts are specified, the firewall will apply only to traffic originating
      from an instance with a service account in this list. Source service accounts cannot be used
      to control traffic to an instance's external IP address because service accounts are
      associated with an instance, not an IP address. sourceRanges can be set at the same time as
      sourceServiceAccounts. If both are set, the firewall will apply to traffic that has source IP
      address within sourceRanges OR the source IP belongs to an instance with service account
      listed in sourceServiceAccount. The connection does not need to match both properties for the
      firewall to apply. sourceServiceAccounts cannot be used at the same time as sourceTags or
      targetTags.
    DOC
  end

  newproperty(:source_tags, parent: Google::Compute::Property::StringArray) do
    desc <<-DOC
      If source tags are specified, the firewall will apply only to traffic with source IP that
      belongs to a tag listed in source tags. Source tags cannot be used to control traffic to an
      instance's external IP address. Because tags are associated with an instance, not an IP
      address. One or both of sourceRanges and sourceTags may be set. If both properties are set,
      the firewall will apply to traffic that has source IP address within sourceRanges OR the
      source IP that belongs to a tag listed in the sourceTags property. The connection does not
      need to match both properties for the firewall to apply.
    DOC
  end

  newproperty(:target_service_accounts, parent: Google::Compute::Property::StringArray) do
    desc <<-DOC
      A list of service accounts indicating sets of instances located in the network that may make
      network connections as specified in allowed[]. targetServiceAccounts cannot be used at the
      same time as targetTags or sourceTags. If neither targetServiceAccounts nor targetTags are
      specified, the firewall rule applies to all instances on the specified network.
    DOC
  end

  newproperty(:target_tags, parent: Google::Compute::Property::StringArray) do
    desc <<-DOC
      A list of instance tags indicating sets of instances located in the network that may make
      network connections as specified in allowed[]. If no targetTags are specified, the firewall
      rule applies to all instances on the specified network.
    DOC
  end

  # Returns all properties that a provider can export to other resources
  def exports
    provider.exports
  end
end
