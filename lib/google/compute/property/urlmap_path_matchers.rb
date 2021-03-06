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
      # A class to manage data for PathMatchers for url_map.
      class UrlMapPathMatchers
        include Comparable

        attr_reader :default_service
        attr_reader :description
        attr_reader :name
        attr_reader :path_rules

        def to_json(_arg = nil)
          {
            'defaultService' => default_service,
            'description' => description,
            'name' => name,
            'pathRules' => path_rules
          }.reject { |_k, v| v.nil? }.to_json
        end

        def to_s
          {
            default_service: default_service,
            description: description,
            name: name,
            path_rules: ['[',
                         (path_rules || []).map(&:to_json).join(', '),
                         ']'].join(' ')
          }.reject { |_k, v| v.nil? }.map { |k, v| "#{k}: #{v}" }.join(', ')
        end

        def ==(other)
          return false unless other.is_a? UrlMapPathMatchers
          compare_fields(other).each do |compare|
            next if compare[:self].nil? || compare[:other].nil?
            return false if compare[:self] != compare[:other]
          end
          true
        end

        def <=>(other)
          return false unless other.is_a? UrlMapPathMatchers
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
            { self: default_service, other: other.default_service },
            { self: description, other: other.description },
            { self: name, other: other.name },
            { self: path_rules, other: other.path_rules }
          ]
        end
      end

      # Manages a UrlMapPathMatchers nested object
      # Data is coming from the GCP API
      class UrlMapPathMatchersApi < UrlMapPathMatchers
        def initialize(args)
          @default_service =
            Google::Compute::Property::BackendServiceSelfLinkRef.api_munge(args['defaultService'])
          @description = Google::Compute::Property::String.api_munge(args['description'])
          @name = Google::Compute::Property::String.api_munge(args['name'])
          @path_rules = Google::Compute::Property::UrlMapPathRulesArray.api_munge(args['pathRules'])
        end
      end

      # Manages a UrlMapPathMatchers nested object
      # Data is coming from the Puppet manifest
      class UrlMapPathMatchersCatalog < UrlMapPathMatchers
        def initialize(args)
          @default_service = Google::Compute::Property::BackendServiceSelfLinkRef.unsafe_munge(
            args['default_service']
          )
          @description = Google::Compute::Property::String.unsafe_munge(args['description'])
          @name = Google::Compute::Property::String.unsafe_munge(args['name'])
          @path_rules =
            Google::Compute::Property::UrlMapPathRulesArray.unsafe_munge(args['path_rules'])
        end
      end
    end

    module Property
      # A class to manage input to PathMatchers for url_map.
      class UrlMapPathMatchers < Google::Compute::Property::Base
        # Used for parsing Puppet catalog
        def unsafe_munge(value)
          self.class.unsafe_munge(value)
        end

        # Used for parsing Puppet catalog
        def self.unsafe_munge(value)
          return if value.nil?
          Data::UrlMapPathMatchersCatalog.new(value)
        end

        # Used for parsing GCP API responses
        def self.api_munge(value)
          return if value.nil?
          Data::UrlMapPathMatchersApi.new(value)
        end
      end

      # A Puppet property that holds an integer
      class UrlMapPathMatchersArray < Google::Compute::Property::Array
        # Used for parsing Puppet catalog
        def unsafe_munge(value)
          self.class.unsafe_munge(value)
        end

        # Used for parsing Puppet catalog
        def self.unsafe_munge(value)
          return if value.nil?
          return UrlMapPathMatchers.unsafe_munge(value) \
            unless value.is_a?(::Array)
          value.map { |v| UrlMapPathMatchers.unsafe_munge(v) }
        end

        # Used for parsing GCP API responses
        def self.api_munge(value)
          return if value.nil?
          return UrlMapPathMatchers.api_munge(value) \
            unless value.is_a?(::Array)
          value.map { |v| UrlMapPathMatchers.api_munge(v) }
        end
      end
    end
  end
end
