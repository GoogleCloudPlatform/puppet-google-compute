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

require 'google/compute/property/array'
require 'puppet/property'

module Google
  module Compute
    module Data
      # A class to manage data for tests for url_map.
      class UrlMapTests
        include Comparable

        attr_reader :description
        attr_reader :host
        attr_reader :path
        attr_reader :service

        def to_json(_arg = nil)
          {
            'description' => description,
            'host' => host,
            'path' => path,
            'service' => service
          }.reject { |_k, v| v.nil? }.to_json
        end

        def to_s
          {
            description: description,
            host: host,
            path: path,
            service: service
          }.reject { |_k, v| v.nil? }.map { |k, v| "#{k}: #{v}" }.join(', ')
        end

        def ==(other)
          return false unless other.is_a? UrlMapTests
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            return false if compare[:self] != compare[:other]
          end
          true
        end

        def <=>(other)
          return false unless other.is_a? UrlMapTests
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            result = compare[:self] <=> compare[:other]
            return result unless result.zero?
          end
          0
        end

        private

        def compare_fields(other)
          [
            { self: description, other: other.description },
            { self: host, other: other.host },
            { self: path, other: other.path },
            { self: service, other: other.service }
          ]
        end
      end

      # Manages a UrlMapTests nested object
      # Data is coming from the GCP API
      class UrlMapTestsApi < UrlMapTests
        def initialize(args)
          @description =
            Google::Compute::Property::String.api_munge(args['description'])
          @host = Google::Compute::Property::String.api_munge(args['host'])
          @path = Google::Compute::Property::String.api_munge(args['path'])
          @service = Google::Compute::Property::BackServSelfLinkRef.api_munge(
            args['service']
          )
        end
      end

      # Manages a UrlMapTests nested object
      # Data is coming from the Puppet manifest
      class UrlMapTestsCatalog < UrlMapTests
        def initialize(args)
          @description =
            Google::Compute::Property::String.unsafe_munge(args['description'])
          @host = Google::Compute::Property::String.unsafe_munge(args['host'])
          @path = Google::Compute::Property::String.unsafe_munge(args['path'])
          @service =
            Google::Compute::Property::BackServSelfLinkRef.unsafe_munge(
              args['service']
            )
        end
      end
    end

    module Property
      # A class to manage input to tests for url_map.
      class UrlMapTests < Puppet::Property
        # Used for parsing Puppet catalog
        def unsafe_munge(value)
          self.class.unsafe_munge(value)
        end

        # Used for parsing Puppet catalog
        def self.unsafe_munge(value)
          return if value.nil?
          Data::UrlMapTestsCatalog.new(value)
        end

        # Used for parsing GCP API responses
        def self.api_munge(value)
          return if value.nil?
          Data::UrlMapTestsApi.new(value)
        end
      end

      # A Puppet property that holds an integer
      class UrlMapTestsArray < Google::Compute::Property::Array
        # Used for parsing Puppet catalog
        def unsafe_munge(value)
          self.class.unsafe_munge(value)
        end

        # Used for parsing Puppet catalog
        def self.unsafe_munge(value)
          return if value.nil?
          return UrlMapTests.unsafe_munge(value) \
            unless value.is_a?(::Array)
          value.map { |v| UrlMapTests.unsafe_munge(v) }
        end

        # Used for parsing GCP API responses
        def self.api_munge(value)
          return if value.nil?
          return UrlMapTests.api_munge(value) \
            unless value.is_a?(::Array)
          value.map { |v| UrlMapTests.api_munge(v) }
        end
      end
    end
  end
end