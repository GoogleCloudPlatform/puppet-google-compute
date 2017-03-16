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

require 'spec_helper'
require 'uri'

class TestCred
  def authorize(request)
    request
  end
end

describe Google::Request::Post do
  before { FakeWeb.clean_registry }

  let(:credential) { TestCred.new }

  let(:uri) { URI('http://www.example.com/test1') }
  let(:body) { { 'test1' => 'test' }.to_json }

  context 'verify proper request' do
    let(:request) { Google::Request::Post.new(uri, credential, body) }

    before do
      expect_success
      request.send
    end

    subject { FakeWeb.last_request }

    it { is_expected.to have_attributes(body: body) }
    it { is_expected.to have_attributes(content_type: 'application/json') }
    it { is_expected.to have_attributes(uri: uri) }
    it { is_expected.to be_a_kind_of(Net::HTTP::Post) }
  end

  context 'post request succeed' do
    before { expect_success }

    subject { Google::Request::Post.new(uri, credential, body).send }

    it { is_expected.to have_attributes(body: { status: 'DONE' }.to_json) }
    it { is_expected.to have_attributes(code: '200') }
  end

  context 'failed request' do
    before { expect_failure }

    subject { Google::Request::Post.new(uri, credential, body).send }

    it { is_expected.to have_attributes(code: '404') }
  end

  def expect_success
    FakeWeb.register_uri(:post, 'http://www.example.com/test1',
                         body: { status: 'DONE' }.to_json,
                         status: 200)
  end

  def expect_failure
    FakeWeb.register_uri(:post, 'http://www.example.com/test1',
                         status: 404)
  end
end
