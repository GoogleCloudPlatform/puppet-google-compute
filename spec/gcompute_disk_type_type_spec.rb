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

describe Puppet::Type.type(:gcompute_disk_type) do
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
      :creation_timestamp,
      :default_disk_size_gb,
      :deprecated_deleted,
      :deprecated_deprecated,
      :deprecated_obsolete,
      :deprecated_replacement,
      :deprecated_state,
      :description,
      :id,
      :name,
      :valid_disk_size
    ].each do |prop|
      it "should have '#{prop}' property" do
        expect(described_class.attrtype(prop)).to eq :property
      end
    end

    it 'supports properties' do
      expect do
        described_class.new(
          title: 'my-object-15',
          creation_timestamp: '3176-04-12T02:10:53+00:00',
          default_disk_size_gb: 33_751_009_625,
          deprecated_deleted: '2831-08-14T04:07:37+00:00',
          deprecated_deprecated: '3328-02-27T07:45:30+00:00',
          deprecated_obsolete: '2582-04-14T09:08:17+00:00',
          deprecated_replacement: 'test deprecated_replacement#15 data',
          deprecated_state: 'DEPRECATED',
          description: 'test description#15 data',
          id: 34_392_013_944,
          name: 'test name#15 data',
          valid_disk_size: 'test valid_disk_size#15 data'
        )
      end.not_to raise_error
    end
  end
end
