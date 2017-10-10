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

require 'puppet'
require 'json'
require 'timeout'

# Load a JSON params object for running a task
Puppet::Functions.create_function(:gcompute_task_validate_param) do
  dispatch :gcompute_task_validate_param do
    param 'Hash', :params
    param 'String', :variable
    param 'String', :default
  end

  # Load parameters from STDIN in JSON format
  def gcompute_task_validate_param(params, arg, default)
    raise "Missing parameter '#{arg}'" \
      if default == '<-undef->' && !params.key?(arg)
    puts "p(#{arg}) = #{params.key?(arg) ? params[arg] : default}"
    params.key?(arg) ? params[arg] : default
  end
end
