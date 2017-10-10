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
require 'puppet/error'
require 'json'
require 'timeout'

# Load a JSON params object for running a task
Puppet::Functions.create_function(:gcompute_task_load_params) do
  dispatch :gcompute_task_load_params do
    param 'String', :input
  end

  # Load parameters from STDIN in JSON format
  def gcompute_task_load_params(input)
    JSON.parse(input)
  rescue JSON::ParserError => e
    throw "Couldn't parse JSON from: #{input}: #{e.message}"
  end
end
