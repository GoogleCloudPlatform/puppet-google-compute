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

require 'google/request/base'
module Google
  module Request
    # A wrapper class for a Post Request
    class Post < Google::Request::Base
      def initialize(link, cred, type, body)
        super(link, cred)
        @type = type
        @body = body
      end

      def transport(request)
        request.content_type = @type
        request.body = @body
        puts "network(#{request}: body(#{@body}))" \
          unless ENV['DEBUG_HTTP_VERBOSE'].nil?
        super(request)
      end
    end
  end
end
