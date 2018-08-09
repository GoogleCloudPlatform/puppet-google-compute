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
require 'google/compute/property/base'

module Google
  module Compute
    module Data
      # A class to manage data for AdvertisedIpRanges for router.
      class RouterAdvertisedIpRanges
        include Comparable

        attr_reader :range
        attr_reader :description

        def to_json(_arg = nil)
          {
            'range' => range,
            'description' => description
          }.reject { |_k, v| v.nil? }.to_json
        end

        def to_s
          {
            range: range,
            description: description
          }.reject { |_k, v| v.nil? }.map { |k, v| "#{k}: #{v}" }.join(', ')
        end

        def ==(other)
          return false unless other.is_a? RouterAdvertisedIpRanges
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            return false if compare[:self] != compare[:other]
          end
          true
        end

        def <=>(other)
          return false unless other.is_a? RouterAdvertisedIpRanges
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
            { self: range, other: other.range },
            { self: description, other: other.description }
          ]
        end
      end

      # Manages a RouterAdvertisedIpRanges nested object
      # Data is coming from the GCP API
      class RouterAdvertisedIpRangesApi < RouterAdvertisedIpRanges
        def initialize(args)
          @range = Google::Compute::Property::String.api_munge(args['range'])
          @description = Google::Compute::Property::String.api_munge(args['description'])
        end
      end

      # Manages a RouterAdvertisedIpRanges nested object
      # Data is coming from the Puppet manifest
      class RouterAdvertisedIpRangesCatalog < RouterAdvertisedIpRanges
        def initialize(args)
          @range = Google::Compute::Property::String.unsafe_munge(args['range'])
          @description = Google::Compute::Property::String.unsafe_munge(args['description'])
        end
      end
    end

    module Property
      # A class to manage input to AdvertisedIpRanges for router.
      class RouterAdvertisedIpRanges < Google::Compute::Property::Base
        # Used for parsing Puppet catalog
        def unsafe_munge(value)
          self.class.unsafe_munge(value)
        end

        # Used for parsing Puppet catalog
        def self.unsafe_munge(value)
          return if value.nil?
          Data::RouterAdvertisedIpRangesCatalog.new(value)
        end

        # Used for parsing GCP API responses
        def self.api_munge(value)
          return if value.nil?
          Data::RouterAdvertisedIpRangesApi.new(value)
        end
      end

      # A Puppet property that holds an integer
      class RouterAdvertisedIpRangesArray < Google::Compute::Property::Array
        # Used for parsing Puppet catalog
        def unsafe_munge(value)
          self.class.unsafe_munge(value)
        end

        # Used for parsing Puppet catalog
        def self.unsafe_munge(value)
          return if value.nil?
          return RouterAdvertisedIpRanges.unsafe_munge(value) \
            unless value.is_a?(::Array)
          value.map { |v| RouterAdvertisedIpRanges.unsafe_munge(v) }
        end

        # Used for parsing GCP API responses
        def self.api_munge(value)
          return if value.nil?
          return RouterAdvertisedIpRanges.api_munge(value) \
            unless value.is_a?(::Array)
          value.map { |v| RouterAdvertisedIpRanges.api_munge(v) }
        end
      end
    end
  end
end
