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
require 'google/compute/property/interconnectattachment_private_interconnect_info'
require 'google/compute/property/region_selflink'
require 'google/compute/property/router_selflink'
require 'google/compute/property/string'
require 'google/compute/property/time'
require 'google/object_store'
require 'puppet'

Puppet::Type.newtype(:gcompute_interconnect_attachment) do
  @doc = <<-DOC
    Represents an InterconnectAttachment (VLAN attachment) resource. For more information, see
    Creating VLAN Attachments.
  DOC

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
    desc 'The name of the InterconnectAttachment.'
  end

  newparam(:region, parent: Google::Compute::Property::RegionSelfLinkRef) do
    desc 'Region where the regional interconnect attachment resides.'
  end

  newproperty(:cloud_router_ip_address, parent: Google::Compute::Property::String) do
    desc <<-DOC
      IPv4 address + prefix length to be configured on Cloud Router Interface for this interconnect
      attachment. (output only)
    DOC
  end

  newproperty(:customer_router_ip_address, parent: Google::Compute::Property::String) do
    desc <<-DOC
      IPv4 address + prefix length to be configured on the customer router subinterface for this
      interconnect attachment. (output only)
    DOC
  end

  newproperty(:interconnect, parent: Google::Compute::Property::String) do
    desc <<-DOC
      URL of the underlying Interconnect object that this attachment's traffic will traverse
      through.
    DOC
  end

  newproperty(:description, parent: Google::Compute::Property::String) do
    desc 'An optional description of this resource.'
  end

  newproperty(:private_interconnect_info,
              parent: Google::Compute::Property::InterconnectAttachmentPrivateInterconnectInfo) do
    desc <<-DOC
      Information specific to an InterconnectAttachment. This property is populated if the
      interconnect that this is attached to is of type DEDICATED. (output only)
    DOC
  end

  newproperty(:google_reference_id, parent: Google::Compute::Property::String) do
    desc <<-DOC
      Google reference ID, to be used when raising support tickets with Google or otherwise to
      debug backend connectivity issues. (output only)
    DOC
  end

  newproperty(:router, parent: Google::Compute::Property::RouterSelfLinkRef) do
    desc <<-DOC
      URL of the cloud router to be used for dynamic routing. This router must be in the same
      region as this InterconnectAttachment. The InterconnectAttachment will automatically connect
      the Interconnect to the network & region within which the Cloud Router is configured.
    DOC
  end

  newproperty(:creation_timestamp, parent: Google::Compute::Property::Time) do
    desc 'Creation timestamp in RFC3339 text format. (output only)'
  end

  newproperty(:id, parent: Google::Compute::Property::String) do
    desc <<-DOC
      The unique identifier for the resource. This identifier is defined by the server. (output
      only)
    DOC
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

  # Returns all properties that a provider can export to other resources
  def exports
    provider.exports
  end
end
