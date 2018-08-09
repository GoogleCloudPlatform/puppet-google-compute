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

require 'google/compute/property/array'
require 'google/object_store'
require 'puppet/property'

module Google
  module Compute
    module Data
      # Base class for ResourceRefs
      # Imports self_link from license
      class LicenseSelfLinkRef
        include Comparable

        def ==(other)
          return false unless other.is_a? LicenseSelfLinkRef
          return false if resource != other.resource
          true
        end

        def <=>(other)
          resource <=> other.resource
        end
      end

      # A class to fetch the resource value from a referenced block
      # Will return the value exported from a different Puppet resource
      class LicenseSelfLinkRefCatalog < LicenseSelfLinkRef
        def initialize(title)
          @title = title
        end

        # Puppet requires the title for autorequiring
        def autorequires
          [@title]
        end

        def to_s
          resource.to_s
        end

        def to_json(_arg = nil)
          return if resource.nil?
          resource.to_json
        end

        def resource
          Google::ObjectStore.instance[:gcompute_license].each do |entry|
            return entry.exports[:self_link] if entry.title == @title
          end

          unless /https:\/\/www.googleapis.com\/compute\/v1\/\/projects\/.*\/global\/licenses\/[a-z1-9\-]*/.match(@title)
            # We'll asssmble the self_link for the user.
            # We need to get the project name to assemble the self_link
            projects = Google::ObjectStore.instance
                                          .resources
                                          .reject { |name, _a| name == :gauth_credential }
                                          .map { |_name, array| array.map(&:exports) }
                                          .flatten
                                          .map { |x| x[:project] }
                                          .compact
                                          .uniq
            return "https://www.googleapis.com/compute/v1//projects/#{projects[0]}/global/licenses/#{@title}" \
              if projects.length == 1
            raise ["Your Puppet manifest contains multiple projects.",
                   "We cannot determine which project you wish to use.",
                   "Please replace #{@title} with a full URL of the form:",
                   "https://www.googleapis.com/compute/v1//projects/{{project}}/global/licenses/{{name}}"
                  ].join(' ')
          end

          @title
        end
      end

      # A class to manage a JSON blob from GCP API
      # Will immediately return value from JSON blob without changes
      class LicenseSelfLinkRefApi < LicenseSelfLinkRef
        attr_reader :resource

        def initialize(resource)
          @resource = resource
        end

        def to_s
          @resource.to_s
        end

        def to_json(_arg = nil)
          @resource.to_json
        end
      end
    end

    module Property
      # A class to manage fetching self_link from a license
      class LicenseSelfLinkRef < Puppet::Property
        # Used for catalog values
        def unsafe_munge(value)
          self.class.unsafe_munge(value)
        end

        def self.unsafe_munge(value)
          return if value.nil?
          Data::LicenseSelfLinkRefCatalog.new(value)
        end

        # Used for fetched JSON values
        def self.api_munge(value)
          return if value.nil?
          Data::LicenseSelfLinkRefApi.new(value)
        end
      end

      # A Puppet property that holds an integer
      class LicenseSelfLinkRefArray < Google::Compute::Property::Array
        # Used for parsing Puppet catalog
        def unsafe_munge(value)
          self.class.unsafe_munge(value)
        end

        # Used for parsing Puppet catalog
        def self.unsafe_munge(value)
          return if value.nil?
          return LicenseSelfLinkRef.unsafe_munge(value) \
            unless value.is_a?(::Array)
          value.map { |v| LicenseSelfLinkRef.unsafe_munge(v) }
        end

        # Used for parsing GCP API responses
        def self.api_munge(value)
          return if value.nil?
          return LicenseSelfLinkRef.api_munge(value) \
            unless value.is_a?(::Array)
          value.map { |v| LicenseSelfLinkRef.api_munge(v) }
        end
      end
    end
  end
end
