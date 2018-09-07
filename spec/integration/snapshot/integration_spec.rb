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
require 'spec_helper'
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

describe 'snapshot.create', vcr: true do
  it 'creates and destroys non-existent snapshot' do
    puts 'pre-destroying snapshot'
    VCR.use_cassette('pre_destroy_snapshot') do
      run_example('delete_snapshot')
    end
    puts 'creating snapshot'
    VCR.use_cassette('create_snapshot') do
      run_example('snapshot')
    end
    puts 'checking that snapshot is created'
    VCR.use_cassette('check_snapshot') do
      validate_no_flush_calls('snapshot')
    end
    puts 'destroying snapshot'
    VCR.use_cassette('destroy_snapshot') do
      run_example('delete_snapshot')
    end
    puts 'confirming snapshot destroyed'
    VCR.use_cassette('check_destroy_snapshot') do
      validate_no_flush_calls('delete_snapshot')
    end
  end
end
