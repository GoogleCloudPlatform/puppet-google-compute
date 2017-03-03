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

describe Puppet::Type.type(:gcompute_address).provider(:google) do
  let(:start_time) { Time.new(2017, 1, 2, 3, 4, 5) }

  A_PROJECT_DATA = %w(
    test\ project#0\ data
    test\ project#1\ data
    test\ project#2\ data
    test\ project#3\ data
    test\ project#4\ data
  ).freeze

  A_REGION_DATA = %w(
    test\ region#0\ data
    test\ region#1\ data
    test\ region#2\ data
    test\ region#3\ data
    test\ region#4\ data
  ).freeze

  A_NAME_DATA = %w(
    test\ name#0\ data
    test\ name#1\ data
    test\ name#2\ data
    test\ name#3\ data
    test\ name#4\ data
  ).freeze

  before do
    FakeWeb.clean_registry
    allow(Time).to receive(:now).and_return(start_time)
  end

  it '#instances' do
    expect { described_class.instances }.to raise_error(StandardError,
                                                        /not supported/)
  end

  context 'create provider' do
    subject { create_type(1).provider }

    it { is_expected.to have_attributes(address: :absent) }
    it { is_expected.to have_attributes(creation_timestamp: :absent) }
    it { is_expected.to have_attributes(description: :absent) }
    it { is_expected.to have_attributes(id: :absent) }
    it { is_expected.to have_attributes(users: :absent) }
  end

  context '#prefetch' do
    before do
      expect_network_get_success 1
      expect_network_get_success 2
      expect_network_get_failed 3
      expect_credential
      debug_network_expectations
    end

    let(:resource1) { create_type 1 }
    let(:resource2) { create_type 2 }
    let(:resource3) { create_type 3 }

    subject { [resource1, resource2, resource3] }

    context 'network' do
      before do
        # Process the resources
        described_class.prefetch(title1: resource1,
                                 title2: resource2,
                                 title3: resource3)
      end

      let(:providers) do
        [resource1.provider, resource2.provider, resource3.provider]
      end

      #
      # Ensure we have the final vales as retrieved from the service
      #

      context 'provider 1' do
        subject { providers[0] }

        it { is_expected.to have_attributes(address: 'test address#0 data') }
        it do
          is_expected
            .to have_attributes(creation_timestamp: '2045-05-23T12:08:10+00:00')
        end
        it do
          is_expected
            .to have_attributes(description: 'test description#0 data')
        end
        it { is_expected.to have_attributes(id: 2_149_500_871) }
        it { is_expected.to have_attributes(name: 'test name#0 data') }
        it { is_expected.to have_attributes(users: %w(ww xx yy zz)) }
      end
      #
      # Ensure we have the final vales as retrieved from the service
      #

      context 'provider 2' do
        subject { providers[1] }

        it { is_expected.to have_attributes(address: 'test address#1 data') }
        it do
          is_expected
            .to have_attributes(creation_timestamp: '2120-10-14T00:16:21+00:00')
        end
        it do
          is_expected
            .to have_attributes(description: 'test description#1 data')
        end
        it { is_expected.to have_attributes(id: 4_299_001_743) }
        it { is_expected.to have_attributes(name: 'test name#1 data') }
        it { is_expected.to have_attributes(users: %w(uu vv)) }
      end

      #
      # Ensure we have the final vales as retrieved from the service
      #

      context 'provider 3' do
        subject { providers[2] }

        it { is_expected.to have_attributes(address: :absent) }
        it { is_expected.to have_attributes(creation_timestamp: :absent) }
        it { is_expected.to have_attributes(description: :absent) }
        it { is_expected.to have_attributes(id: :absent) }
        it { is_expected.to have_attributes(users: :absent) }
      end
    end
  end

  context '#exists' do
    context 'with ensure set to :present' do
      subject do
        Puppet::Type.type(:gcompute_address).provider(:google).new(
          ensure: :present
        ).exists?
      end

      it { is_expected.to be true }
    end

    context 'with ensure set to :absent' do
      subject do
        Puppet::Type.type(:gcompute_address).provider(:google).new(
          ensure: :absent
        ).exists?
      end

      it { is_expected.to be false }
    end
  end

  #------------------------------------------------------------------
  context '#create' do
    context 'title only' do
      before do
        expect_network_create 4
        expect_credential
        debug_network_expectations

        Puppet::Type.type(:gcompute_address).new(
          title: 'title4',
          address: 'test address#3 data',
          creation_timestamp: '2271-07-28T00:32:43+00:00',
          description: 'test description#3 data',
          id: 8_598_003_486,
          users: %w(qq rr),
          region: 'test region#3 data',
          project: 'test project#3 data',
          credential: 'cred3'
        ).provider.create
      end

      let(:expected_results) do
        {
          'kind' => 'compute#address',
          'address' => 'test address#3 data',
          'description' => 'test description#3 data',
          'name' => 'title4'
        }
      end

      subject { JSON.parse(FakeWeb.last_request.body) }

      it { is_expected.to eq expected_results }
    end

    context 'title and name' do
      before do
        expect_network_create 4
        expect_credential
        debug_network_expectations

        Puppet::Type.type(:gcompute_address).new(
          title: 'title4',
          address: 'test address#3 data',
          creation_timestamp: '2271-07-28T00:32:43+00:00',
          description: 'test description#3 data',
          id: 8_598_003_486,
          name: 'test name#3 data',
          users: %w(qq rr),
          region: 'test region#3 data',
          project: 'test project#3 data',
          credential: 'cred3'
        ).provider.create
      end

      let(:expected_results) do
        {
          'kind' => 'compute#address',
          'address' => 'test address#3 data',
          'description' => 'test description#3 data',
          'name' => 'test name#3 data'
        }
      end

      subject { JSON.parse(FakeWeb.last_request.body) }

      it { is_expected.to eq expected_results }
    end
  end

  #------------------------------------------------------------------
  context '#delete' do
    context 'title only' do
      before do
        expect_network_delete 3, 'title3'
        expect_credential
        debug_network_expectations

        Puppet::Type.type(:gcompute_address).new(
          title: 'title3',
          region: 'test region#2 data',
          project: 'test project#2 data',
          credential: 'cred2'
        ).provider.delete
      end

      it { expect(FakeWeb.last_request.method).to eq 'DELETE' }
    end

    context 'title and name' do
      before do
        expect_network_delete 3
        expect_credential
        debug_network_expectations

        Puppet::Type.type(:gcompute_address).new(
          title: 'title3',
          name: 'test name#2 data',
          region: 'test region#2 data',
          project: 'test project#2 data',
          credential: 'cred2'
        ).provider.delete
      end

      it { expect(FakeWeb.last_request.method).to eq 'DELETE' }
    end
  end

  context '#flush' do
    subject do
      Puppet::Type.type(:gcompute_address).new(
        ensure: :present,
        name: 'my-name'
      ).provider
    end

    context 'no-op' do
      it { subject.flush }
    end

    context 'modified object' do
      before do
        subject.dirty :some_property, 'current', 'newvalue'
      end

      context 'no-op if created' do
        before { subject.instance_variable_set(:@created, true) }
        it { expect { subject.flush }.not_to raise_error }
      end

      context 'no-op if deleted' do
        before { subject.instance_variable_set(:@deleted, true) }
        it { expect { subject.flush }.not_to raise_error }
      end
    end
  end

  private

  def expect_credential
    cred = double('cred')
    Puppet::Type.type(:gauth_credential)
                .define_singleton_method(:fetch) { |_resource| cred }
    allow(cred).to receive(:authorize) { |arg| arg }
  end

  def expect_network_get_success(id)
    FakeWeb.register_uri(:get, self_link(uri_data(id)),
                         body: load_network_result("success#{id}.yaml").to_json)
  end

  def expect_network_get_failed(id)
    FakeWeb.register_uri(:get, self_link(uri_data(id)), status: 404)
  end

  def expect_network_create(id)
    FakeWeb.register_uri(:post,
                         collection(uri_data(id)),
                         status: 200,
                         body: { kind: 'compute#address' }.to_json)
  end

  def expect_network_delete(id, name = nil)
    delete_data = uri_data(id)
    delete_data[:name] = name unless name.nil?
    FakeWeb.register_uri(:delete, self_link(delete_data), status: 204)
  end

  def create_type(id)
    Puppet::Type.type(:gcompute_address).new(
      ensure: :present,
      title: "title#{id - 1}",
      credential: "cred#{id - 1}",
      project: A_PROJECT_DATA[(id - 1) % A_PROJECT_DATA.size],
      region: A_REGION_DATA[(id - 1) % A_REGION_DATA.size],
      name: A_NAME_DATA[(id - 1) % A_NAME_DATA.size]
    )
  end

  def collection(data)
    URI.join(
      'https://www.googleapis.com/compute/v1/',
      expand_variables(
        'projects/{{project}}/regions/{{region}}/addresses',
        data
      )
    )
  end

  def self_link(data)
    URI.join(
      'https://www.googleapis.com/compute/v1/',
      expand_variables(
        'projects/{{project}}/regions/{{region}}/addresses/{{name}}',
        data
      )
    )
  end

  def expand_variables(template, data, extra_data = {})
    Puppet::Type.type(:gcompute_address).provider(:google)
                .expand_variables(template, data, extra_data)
  end

  # Creates variable test data to comply with self_link URI parameters
  def uri_data(id)
    {
      project: A_PROJECT_DATA[(id - 1) % A_PROJECT_DATA.size],
      region: A_REGION_DATA[(id - 1) % A_REGION_DATA.size],
      name: A_NAME_DATA[(id - 1) % A_NAME_DATA.size]
    }
  end

  def load_network_result(file)
    results = File.join(File.dirname(__FILE__), 'data', 'network',
                        'gcompute_address', file)
    raise "Network result data file #{results}" unless File.exist?(results)
    data = YAML.safe_load(File.read(results))
    raise "Invalid network results #{results}" unless data.class <= Hash
    data
  end

  def debug_network_expectations
    FakeWeb::Registry.instance.uri_map.each do |name, _value|
      puts "Expect network: #{name}" if ENV['RSPEC_DEBUG']
    end
  end
end
