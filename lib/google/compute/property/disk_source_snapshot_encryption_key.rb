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

require 'puppet/property'

module Google
  module Compute
    module Data
      # A class to manage data for source_snapshot_encryption_key for disk.
      class DiskSourSnapEncrKey
        include Comparable

        attr_reader :raw_key
        attr_reader :sha256

        def to_json(_arg = nil)
          {
            'rawKey' => raw_key,
            'sha256' => sha256
          }.to_json
        end

        def to_s
          {
            raw_key: raw_key,
            sha256: sha256
          }.map { |k, v| "#{k}: #{v}" }.join(', ')
        end

        def ==(other)
          return false unless other.is_a? DiskSourSnapEncrKey
          return false if raw_key != other.raw_key
          return false if sha256 != other.sha256
          true
        end

        def <=>(other)
          result = raw_key.<=>(other.raw_key)
          return result unless result.zero?
          result = sha256.<=>(other.sha256)
          return result unless result.zero?
          0
        end
      end

      # Manages a DiskSourSnapEncrKey nested object
      # Data is coming from the GCP API
      class DiskSourSnapEncrKeyApi < DiskSourSnapEncrKey
        def initialize(args)
          @raw_key = Google::Compute::Property::String.api_munge(
            args['raw_key'] || args['rawKey']
          )
          @sha256 = Google::Compute::Property::String.api_munge(args['sha256'])
        end
      end

      # Manages a DiskSourSnapEncrKey nested object
      # Data is coming from the Puppet manifest
      class DiskSourSnapEncrKeyCatalog < DiskSourSnapEncrKey
        def initialize(args)
          @raw_key = Google::Compute::Property::String.unsafe_munge(
            args['raw_key'] || args['rawKey']
          )
          @sha256 = Google::Compute::Property::String.unsafe_munge(
            args['sha256']
          )
        end
      end
    end

    module Property
      # A class to manage input to source_snapshot_encryption_key for disk.
      class DiskSourSnapEncrKey < Puppet::Property
        # Used for parsing Puppet catalog
        def unsafe_munge(value)
          self.class.unsafe_munge(value)
        end

        # Used for parsing Puppet catalog
        def self.unsafe_munge(value)
          return if value.nil?
          Data::DiskSourSnapEncrKeyCatalog.new(value)
        end

        # Used for parsing GCP API responses
        def self.api_munge(value)
          return if value.nil?
          Data::DiskSourSnapEncrKeyApi.new(value)
        end
      end
    end
  end
end
