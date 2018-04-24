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

require 'google/compute/property/enum'
require 'google/compute/property/healthcheck_http_health_check'
require 'google/compute/property/healthcheck_https_health_check'
require 'google/compute/property/healthcheck_ssl_health_check'
require 'google/compute/property/healthcheck_tcp_health_check'
require 'google/compute/property/integer'
require 'google/compute/property/string'
require 'google/compute/property/time'
require 'puppet'

Puppet::Type.newtype(:gcompute_health_check) do
  @doc = <<-DOC
    An HealthCheck resource. This resource defines a template for how
    individual virtual machines should be checked for health, via one of the
    supported protocols.
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
    desc 'The name of the HealthCheck.'
  end

  newproperty(:check_interval_sec,
              parent: Google::Compute::Property::Integer) do
    desc <<-DOC
      How often (in seconds) to send a health check. The default value is 5
      seconds.
    DOC
  end

  newproperty(:creation_timestamp, parent: Google::Compute::Property::Time) do
    desc 'Creation timestamp in RFC3339 text format. (output only)'
  end

  newproperty(:description, parent: Google::Compute::Property::String) do
    desc <<-DOC
      An optional description of this resource. Provide this property when you
      create the resource.
    DOC
  end

  newproperty(:healthy_threshold, parent: Google::Compute::Property::Integer) do
    desc <<-DOC
      A so-far unhealthy instance will be marked healthy after this many
      consecutive successes. The default value is 2.
    DOC
  end

  newproperty(:id, parent: Google::Compute::Property::Integer) do
    desc <<-DOC
      The unique identifier for the resource. This identifier is defined by the
      server. (output only)
    DOC
  end

  newproperty(:name, parent: Google::Compute::Property::String) do
    desc <<-DOC
      Name of the resource. Provided by the client when the resource is
      created. The name must be 1-63 characters long, and comply with RFC1035.
      Specifically, the name must be 1-63 characters long and match the regular
      expression `[a-z]([-a-z0-9]*[a-z0-9])?` which means the first character
      must be a lowercase letter, and all following characters must be a dash,
      lowercase letter, or digit, except the last character, which cannot be a
      dash.
    DOC
  end

  newproperty(:timeout_sec, parent: Google::Compute::Property::Integer) do
    desc <<-DOC
      How long (in seconds) to wait before claiming failure. The default value
      is 5 seconds. It is invalid for timeoutSec to have greater value than
      checkIntervalSec.
    DOC
  end

  newproperty(:unhealthy_threshold,
              parent: Google::Compute::Property::Integer) do
    desc <<-DOC
      A so-far healthy instance will be marked unhealthy after this many
      consecutive failures. The default value is 2.
    DOC
  end

  newproperty(:type, parent: Google::Compute::Property::Enum) do
    desc <<-DOC
      Specifies the type of the healthCheck, either TCP, SSL, HTTP or HTTPS. If
      not specified, the default is TCP. Exactly one of the protocol-specific
      health check field must be specified, which must match type field.
    DOC
    newvalue(:TCP)
    newvalue(:SSL)
    newvalue(:HTTP)
  end

  newproperty(:http_health_check,
              parent: Google::Compute::Property::HealChecHttpHealChec) do
    desc 'A nested object resource'
  end

  newproperty(:https_health_check,
              parent: Google::Compute::Property::HealChecHttpHealChec) do
    desc 'A nested object resource'
  end

  newproperty(:tcp_health_check,
              parent: Google::Compute::Property::HealChecTcpHealChec) do
    desc 'A nested object resource'
  end

  newproperty(:ssl_health_check,
              parent: Google::Compute::Property::HealChecSslHealChec) do
    desc 'A nested object resource'
  end
end