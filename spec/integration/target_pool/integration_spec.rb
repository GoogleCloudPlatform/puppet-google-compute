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

describe 'target_pool.create', vcr: true do
  it 'creates and destroys non-existent target_pool' do
    puts 'pre-destroying target_pool'
    VCR.use_cassette('pre_destroy_target_pool') do
      run_example('delete_target_pool')
    end
    puts 'creating target_pool'
    VCR.use_cassette('create_target_pool') do
      run_example('target_pool')
    end
    puts 'checking that target_pool is created'
    VCR.use_cassette('check_target_pool') do
      validate_no_flush_calls('target_pool')
    end
    puts 'destroying target_pool'
    VCR.use_cassette('destroy_target_pool') do
      run_example('delete_target_pool')
    end
    puts 'confirming target_pool destroyed'
    VCR.use_cassette('check_destroy_target_pool') do
      validate_no_flush_calls('delete_target_pool')
    end
  end
end
