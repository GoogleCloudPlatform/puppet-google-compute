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

module Google
  module Compute
    # A helper class to initialize settings for Bolt
    class Bolt
      def self.init
        # We want to re-use code already written for the GCP modules
        Puppet.initialize_settings

        # Puppet apply does special stuff to load library code stored in modules
        # but that magic is available in Bolt so we emulate it here.  We look in
        # the local user's .puppetlabs directory or if running at "root" we look
        # in the directory where Puppet pluginsyncs to.
        libdir = if Puppet.run_mode.user?
                   Dir["#{Puppet.settings[:codedir]}/modules/*/lib"]
                 else
                   File.path("#{Puppet.settings[:vardir]}/lib").to_a
                 end
        libdir << File.expand_path("#{File.dirname(__FILE__)}/../lib")
        libdir.each { |l| $LOAD_PATH.unshift(l) unless $LOAD_PATH.include?(l) }
      end
    end
  end
end
