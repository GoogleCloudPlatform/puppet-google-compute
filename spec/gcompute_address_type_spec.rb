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
# ----------------------------------------------------------------------------

require 'spec_helper'

describe Puppet::Type.type(:gcompute_address) do
  it "should have 'name' as key" do
    expect(described_class.key_attributes).to contain_exactly :name
  end

  context 'common parameters' do
    [:project, :credential].each do |param|
      it "should have '#{param}' parameter" do
        expect(described_class.attrtype(param)).to eq :param
      end
    end
  end

  context 'object properties' do
    [
      :address,
      :creation_timestamp,
      :description,
      :id,
      :name,
      :users
    ].each do |prop|
      it "should have '#{prop}' property" do
        expect(described_class.attrtype(prop)).to eq :property
      end
    end

    it 'supports properties' do
      expect do
        described_class.new(
          ensure: :present,
          title: 'my-object-15',
          address: 'test address#15 data',
          creation_timestamp: '3176-04-12T02:10:53+00:00',
          description: 'test description#15 data',
          id: 34_392_013_944,
          name: 'test name#15 data',
          users: %w(ss tt)
        )
      end.not_to raise_error
    end
  end

  context 'ensure' do
    [:present, :absent].each do |value|
      it "should support '#{value}' to ensure" do
        expect do
          described_class.new(ensure: value,
                              name: 'my-object')
        end.to_not raise_error
      end
    end

    it 'should not support other values' do
      expect do
        described_class.new(ensure: 'foo',
                            name: 'my-object')
      end.to raise_error(Puppet::Error, /Invalid value/)
    end
  end
end
