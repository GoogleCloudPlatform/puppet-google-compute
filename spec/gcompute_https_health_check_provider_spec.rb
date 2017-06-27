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
#     Please read more about how to change this file in README.md and
#     CONTRIBUTING.md located at the root of this package.
#
# ----------------------------------------------------------------------------

require 'spec_helper'

describe Puppet::Type.type(:gcompute_https_health_check).provider(:google) do
  before(:all) do
    cred = Google::FakeAuthorization.new
    Puppet::Type.type(:gauth_credential)
                .define_singleton_method(:fetch) { |_resource| cred }
  end

  HHC_PROJECT_DATA = %w[
    test\ project#0\ data
    test\ project#1\ data
    test\ project#2\ data
    test\ project#3\ data
    test\ project#4\ data
  ].freeze

  HHC_NAME_DATA = %w[
    test\ name#0\ data
    test\ name#1\ data
    test\ name#2\ data
    test\ name#3\ data
    test\ name#4\ data
  ].freeze

  it '#instances' do
    expect { described_class.instances }.to raise_error(StandardError,
                                                        /not supported/)
  end

  context 'ensure == present' do
    context 'resource exists' do
      # Ensure present: resource exists, no change
      context 'no changes == no action' do
        # Ensure present: resource exists, no change, no name
        context 'title == name' do
          # Ensure present: resource exists, no change, no name, pass
          context 'title == name (pass)' do
            before do
              allow(Time).to receive(:now).and_return(
                Time.new(2017, 1, 2, 3, 4, 5)
              )
              expect_network_get_success 1, name: 'title0'
              expect_network_get_success 2, name: 'title1'
              expect_network_get_success 3, name: 'title2'
            end

            let(:catalog) do
              apply_compiled_manifest(
                <<-MANIFEST
                gcompute_https_health_check { 'title0':
                  ensure              => present,
                  check_interval_sec  => 242040324,
                  description         => 'test description#0 data',
                  healthy_threshold   => 295703256,
                  host                => 'test host#0 data',
                  port                => 759512136,
                  request_path        => 'test request_path#0 data',
                  timeout_sec         => 2704031721,
                  unhealthy_threshold => 1604513019,
                  project             => 'test project#0 data',
                  credential          => 'cred0',
                }
                gcompute_https_health_check { 'title1':
                  ensure              => present,
                  check_interval_sec  => 484080649,
                  description         => 'test description#1 data',
                  healthy_threshold   => 591406512,
                  host                => 'test host#1 data',
                  port                => 1519024273,
                  request_path        => 'test request_path#1 data',
                  timeout_sec         => 5408063442,
                  unhealthy_threshold => 3209026038,
                  project             => 'test project#1 data',
                  credential          => 'cred1',
                }
                gcompute_https_health_check { 'title2':
                  ensure              => present,
                  check_interval_sec  => 726120974,
                  description         => 'test description#2 data',
                  healthy_threshold   => 887109769,
                  host                => 'test host#2 data',
                  port                => 2278536410,
                  request_path        => 'test request_path#2 data',
                  timeout_sec         => 8112095164,
                  unhealthy_threshold => 4813539057,
                  project             => 'test project#2 data',
                  credential          => 'cred2',
                }
                MANIFEST
              ).catalog
            end

            context 'Gcompute_https_health_check[title0]' do
              subject do
                catalog.resource('Gcompute_https_health_check[title0]').provider
              end

              it do
                is_expected.to have_attributes(check_interval_sec: 242_040_324)
              end
              it do
                is_expected
                  .to have_attributes(
                    creation_timestamp: '2045-05-23T12:08:10+00:00'
                  )
              end
              it do
                is_expected
                  .to have_attributes(description: 'test description#0 data')
              end
              it do
                is_expected.to have_attributes(healthy_threshold: 295_703_256)
              end
              it { is_expected.to have_attributes(host: 'test host#0 data') }
              it { is_expected.to have_attributes(id: 2_149_500_871) }
              it { is_expected.to have_attributes(name: 'title0') }
              it { is_expected.to have_attributes(port: 759_512_136) }
              it do
                is_expected
                  .to have_attributes(request_path: 'test request_path#0 data')
              end
              it { is_expected.to have_attributes(timeout_sec: 2_704_031_721) }
              it do
                is_expected
                  .to have_attributes(unhealthy_threshold: 1_604_513_019)
              end
            end

            context 'Gcompute_https_health_check[title1]' do
              subject do
                catalog.resource('Gcompute_https_health_check[title1]').provider
              end

              it do
                is_expected.to have_attributes(check_interval_sec: 484_080_649)
              end
              it do
                is_expected
                  .to have_attributes(
                    creation_timestamp: '2120-10-14T00:16:21+00:00'
                  )
              end
              it do
                is_expected
                  .to have_attributes(description: 'test description#1 data')
              end
              it do
                is_expected.to have_attributes(healthy_threshold: 591_406_512)
              end
              it { is_expected.to have_attributes(host: 'test host#1 data') }
              it { is_expected.to have_attributes(id: 4_299_001_743) }
              it { is_expected.to have_attributes(name: 'title1') }
              it { is_expected.to have_attributes(port: 1_519_024_273) }
              it do
                is_expected
                  .to have_attributes(request_path: 'test request_path#1 data')
              end
              it { is_expected.to have_attributes(timeout_sec: 5_408_063_442) }
              it do
                is_expected
                  .to have_attributes(unhealthy_threshold: 3_209_026_038)
              end
            end

            context 'Gcompute_https_health_check[title2]' do
              subject do
                catalog.resource('Gcompute_https_health_check[title2]').provider
              end

              it do
                is_expected.to have_attributes(check_interval_sec: 726_120_974)
              end
              it do
                is_expected
                  .to have_attributes(
                    creation_timestamp: '2196-03-05T12:24:32+00:00'
                  )
              end
              it do
                is_expected
                  .to have_attributes(description: 'test description#2 data')
              end
              it do
                is_expected.to have_attributes(healthy_threshold: 887_109_769)
              end
              it { is_expected.to have_attributes(host: 'test host#2 data') }
              it { is_expected.to have_attributes(id: 6_448_502_614) }
              it { is_expected.to have_attributes(name: 'title2') }
              it { is_expected.to have_attributes(port: 2_278_536_410) }
              it do
                is_expected
                  .to have_attributes(request_path: 'test request_path#2 data')
              end
              it { is_expected.to have_attributes(timeout_sec: 8_112_095_164) }
              it do
                is_expected
                  .to have_attributes(unhealthy_threshold: 4_813_539_057)
              end
            end
          end

          # Ensure present: resource exists, no change, no name, fail
          context 'title == name (fail)' do
            # TODO(nelsonjr): Implement new test format.
            subject { -> { raise '[placeholder] This should fail.' } }
            it { is_expected.to raise_error(RuntimeError, /placeholder/) }
          end
        end

        # Ensure present: resource exists, no change, has name
        context 'title != name' do
          # Ensure present: resource exists, no change, has name, pass
          context 'title != name (pass)' do
            before do
              allow(Time).to receive(:now).and_return(
                Time.new(2017, 1, 2, 3, 4, 5)
              )
              expect_network_get_success 1
              expect_network_get_success 2
              expect_network_get_success 3
            end

            let(:catalog) do
              apply_compiled_manifest(
                <<-MANIFEST
                gcompute_https_health_check { 'title0':
                  ensure              => present,
                  check_interval_sec  => 242040324,
                  description         => 'test description#0 data',
                  healthy_threshold   => 295703256,
                  host                => 'test host#0 data',
                  name                => 'test name#0 data',
                  port                => 759512136,
                  request_path        => 'test request_path#0 data',
                  timeout_sec         => 2704031721,
                  unhealthy_threshold => 1604513019,
                  project             => 'test project#0 data',
                  credential          => 'cred0',
                }
                gcompute_https_health_check { 'title1':
                  ensure              => present,
                  check_interval_sec  => 484080649,
                  description         => 'test description#1 data',
                  healthy_threshold   => 591406512,
                  host                => 'test host#1 data',
                  name                => 'test name#1 data',
                  port                => 1519024273,
                  request_path        => 'test request_path#1 data',
                  timeout_sec         => 5408063442,
                  unhealthy_threshold => 3209026038,
                  project             => 'test project#1 data',
                  credential          => 'cred1',
                }
                gcompute_https_health_check { 'title2':
                  ensure              => present,
                  check_interval_sec  => 726120974,
                  description         => 'test description#2 data',
                  healthy_threshold   => 887109769,
                  host                => 'test host#2 data',
                  name                => 'test name#2 data',
                  port                => 2278536410,
                  request_path        => 'test request_path#2 data',
                  timeout_sec         => 8112095164,
                  unhealthy_threshold => 4813539057,
                  project             => 'test project#2 data',
                  credential          => 'cred2',
                }
                MANIFEST
              ).catalog
            end

            context 'Gcompute_https_health_check[title0]' do
              subject do
                catalog.resource('Gcompute_https_health_check[title0]').provider
              end

              it do
                is_expected.to have_attributes(check_interval_sec: 242_040_324)
              end
              it do
                is_expected
                  .to have_attributes(
                    creation_timestamp: '2045-05-23T12:08:10+00:00'
                  )
              end
              it do
                is_expected
                  .to have_attributes(description: 'test description#0 data')
              end
              it do
                is_expected.to have_attributes(healthy_threshold: 295_703_256)
              end
              it { is_expected.to have_attributes(host: 'test host#0 data') }
              it { is_expected.to have_attributes(id: 2_149_500_871) }
              it { is_expected.to have_attributes(name: 'test name#0 data') }
              it { is_expected.to have_attributes(port: 759_512_136) }
              it do
                is_expected
                  .to have_attributes(request_path: 'test request_path#0 data')
              end
              it { is_expected.to have_attributes(timeout_sec: 2_704_031_721) }
              it do
                is_expected
                  .to have_attributes(unhealthy_threshold: 1_604_513_019)
              end
            end

            context 'Gcompute_https_health_check[title1]' do
              subject do
                catalog.resource('Gcompute_https_health_check[title1]').provider
              end

              it do
                is_expected.to have_attributes(check_interval_sec: 484_080_649)
              end
              it do
                is_expected
                  .to have_attributes(
                    creation_timestamp: '2120-10-14T00:16:21+00:00'
                  )
              end
              it do
                is_expected
                  .to have_attributes(description: 'test description#1 data')
              end
              it do
                is_expected.to have_attributes(healthy_threshold: 591_406_512)
              end
              it { is_expected.to have_attributes(host: 'test host#1 data') }
              it { is_expected.to have_attributes(id: 4_299_001_743) }
              it { is_expected.to have_attributes(name: 'test name#1 data') }
              it { is_expected.to have_attributes(port: 1_519_024_273) }
              it do
                is_expected
                  .to have_attributes(request_path: 'test request_path#1 data')
              end
              it { is_expected.to have_attributes(timeout_sec: 5_408_063_442) }
              it do
                is_expected
                  .to have_attributes(unhealthy_threshold: 3_209_026_038)
              end
            end

            context 'Gcompute_https_health_check[title2]' do
              subject do
                catalog.resource('Gcompute_https_health_check[title2]').provider
              end

              it do
                is_expected.to have_attributes(check_interval_sec: 726_120_974)
              end
              it do
                is_expected
                  .to have_attributes(
                    creation_timestamp: '2196-03-05T12:24:32+00:00'
                  )
              end
              it do
                is_expected
                  .to have_attributes(description: 'test description#2 data')
              end
              it do
                is_expected.to have_attributes(healthy_threshold: 887_109_769)
              end
              it { is_expected.to have_attributes(host: 'test host#2 data') }
              it { is_expected.to have_attributes(id: 6_448_502_614) }
              it { is_expected.to have_attributes(name: 'test name#2 data') }
              it { is_expected.to have_attributes(port: 2_278_536_410) }
              it do
                is_expected
                  .to have_attributes(request_path: 'test request_path#2 data')
              end
              it { is_expected.to have_attributes(timeout_sec: 8_112_095_164) }
              it do
                is_expected
                  .to have_attributes(unhealthy_threshold: 4_813_539_057)
              end
            end
          end

          # Ensure present: resource exists, no change, has name, fail
          context 'title != name (fail)' do
            # TODO(nelsonjr): Implement new test format.
            subject { -> { raise '[placeholder] This should fail.' } }
            it { is_expected.to raise_error(RuntimeError, /placeholder/) }
          end
        end
      end

      # Ensure present: resource exists, changes
      context 'changes == action' do
        # Ensure present: resource exists, changes, no name
        context 'title == name' do
          # Ensure present: resource exists, changes, no name, pass
          context 'title == name (pass)' do
            # TODO(nelsonjr): Implement new test format.
          end

          # Ensure present: resource exists, changes, no name, fail
          context 'title == name (fail)' do
            # TODO(nelsonjr): Implement new test format.
            subject { -> { raise '[placeholder] This should fail.' } }
            it { is_expected.to raise_error(RuntimeError, /placeholder/) }
          end
        end

        # Ensure present: resource exists, changes, has name
        context 'title != name' do
          # Ensure present: resource exists, changes, has name, pass
          context 'title != name (pass)' do
            # TODO(nelsonjr): Implement new test format.
          end

          # Ensure present: resource exists, changes, has name, fail
          context 'title != name (fail)' do
            # TODO(nelsonjr): Implement new test format.
            subject { -> { raise '[placeholder] This should fail.' } }
            it { is_expected.to raise_error(RuntimeError, /placeholder/) }
          end
        end
      end
    end

    context 'resource missing' do
      # Ensure present: resource missing, ignore, no name
      context 'title == name' do
        # Ensure present: resource missing, ignore, no name, pass
        context 'title == name (pass)' do
          before(:each) do
            expect_network_get_failed 1, name: 'title0'
            expect_network_create \
              1,
              {
                'kind' => 'compute#httpsHealthCheck',
                'checkIntervalSec' => 242_040_324,
                'description' => 'test description#0 data',
                'healthyThreshold' => 295_703_256,
                'host' => 'test host#0 data',
                'name' => 'title0',
                'port' => 759_512_136,
                'requestPath' => 'test request_path#0 data',
                'timeoutSec' => 2_704_031_721,
                'unhealthyThreshold' => 1_604_513_019
              },
              name: 'title0'
            expect_network_get_async 1, name: 'title0'
          end

          subject do
            apply_compiled_manifest(
              <<-MANIFEST
              gcompute_https_health_check { 'title0':
                ensure              => present,
                check_interval_sec  => 242040324,
                description         => 'test description#0 data',
                healthy_threshold   => 295703256,
                host                => 'test host#0 data',
                port                => 759512136,
                request_path        => 'test request_path#0 data',
                timeout_sec         => 2704031721,
                unhealthy_threshold => 1604513019,
                project             => 'test project#0 data',
                credential          => 'cred0',
              }
              MANIFEST
            ).catalog.resource('Gcompute_https_health_check[title0]').provider
              .ensure
          end

          it { is_expected.to eq :present }
        end

        # Ensure present: resource missing, ignore, no name, fail
        context 'title == name (fail)' do
          # TODO(nelsonjr): Implement new test format.
          subject { -> { raise '[placeholder] This should fail.' } }
          it { is_expected.to raise_error(RuntimeError, /placeholder/) }
        end
      end

      # Ensure present: resource missing, ignore, has name
      context 'title != name' do
        # Ensure present: resource missing, ignore, has name, pass
        context 'title != name (pass)' do
          before(:each) do
            expect_network_get_failed 1
            expect_network_create \
              1,
              'kind' => 'compute#httpsHealthCheck',
              'checkIntervalSec' => 242_040_324,
              'description' => 'test description#0 data',
              'healthyThreshold' => 295_703_256,
              'host' => 'test host#0 data',
              'name' => 'test name#0 data',
              'port' => 759_512_136,
              'requestPath' => 'test request_path#0 data',
              'timeoutSec' => 2_704_031_721,
              'unhealthyThreshold' => 1_604_513_019
            expect_network_get_async 1
          end

          subject do
            apply_compiled_manifest(
              <<-MANIFEST
              gcompute_https_health_check { 'title0':
                ensure              => present,
                check_interval_sec  => 242040324,
                description         => 'test description#0 data',
                healthy_threshold   => 295703256,
                host                => 'test host#0 data',
                name                => 'test name#0 data',
                port                => 759512136,
                request_path        => 'test request_path#0 data',
                timeout_sec         => 2704031721,
                unhealthy_threshold => 1604513019,
                project             => 'test project#0 data',
                credential          => 'cred0',
              }
              MANIFEST
            ).catalog.resource('Gcompute_https_health_check[title0]').provider
              .ensure
          end

          it { is_expected.to eq :present }
        end

        # Ensure present: resource missing, ignore, has name, fail
        context 'title != name (fail)' do
          # TODO(nelsonjr): Implement new test format.
          subject { -> { raise '[placeholder] This should fail.' } }
          it { is_expected.to raise_error(RuntimeError, /placeholder/) }
        end
      end
    end
  end

  context 'ensure == absent' do
    context 'resource missing' do
      # Ensure absent: resource missing, ignore, no name
      context 'title == name' do
        # Ensure absent: resource missing, ignore, no name, pass
        context 'title == name (pass)' do
          before(:each) do
            expect_network_get_failed 1, name: 'title0'
          end

          subject do
            apply_compiled_manifest(
              <<-MANIFEST
              gcompute_https_health_check { 'title0':
                ensure     => absent,
                project    => 'test project#0 data',
                credential => 'cred0',
              }
            MANIFEST
            ).catalog.resource('Gcompute_https_health_check[title0]')
              .provider.ensure
          end

          it { is_expected.to eq :absent }
        end

        # Ensure absent: resource missing, ignore, no name, fail
        context 'title == name (fail)' do
          # TODO(nelsonjr): Implement new test format.
          subject { -> { raise '[placeholder] This should fail.' } }
          it { is_expected.to raise_error(RuntimeError, /placeholder/) }
        end
      end

      # Ensure absent: resource missing, ignore, has name
      context 'title != name' do
        # Ensure absent: resource missing, ignore, has name, pass
        context 'title != name (pass)' do
          before(:each) do
            expect_network_get_failed 1
          end

          subject do
            apply_compiled_manifest(
              <<-MANIFEST
              gcompute_https_health_check { 'title0':
                ensure     => absent,
                name       => 'test name#0 data',
                project    => 'test project#0 data',
                credential => 'cred0',
              }
            MANIFEST
            ).catalog.resource('Gcompute_https_health_check[title0]')
              .provider.ensure
          end

          it { is_expected.to eq :absent }
        end

        # Ensure absent: resource missing, ignore, has name, fail
        context 'title != name (fail)' do
          # TODO(nelsonjr): Implement new test format.
          subject { -> { raise '[placeholder] This should fail.' } }
          it { is_expected.to raise_error(RuntimeError, /placeholder/) }
        end
      end
    end

    context 'resource exists' do
      # Ensure absent: resource exists, ignore, no name
      context 'title == name' do
        # Ensure absent: resource exists, ignore, no name, pass
        context 'title == name (pass)' do
          before(:each) do
            expect_network_get_success 1, name: 'title0'
            expect_network_delete 1, 'title0'
            expect_network_get_async 1, name: 'title0'
          end

          subject do
            apply_compiled_manifest(
              <<-MANIFEST
              gcompute_https_health_check { 'title0':
                ensure     => absent,
                project    => 'test project#0 data',
                credential => 'cred0',
              }
              MANIFEST
            ).catalog.resource('Gcompute_https_health_check[title0]')
              .provider.ensure
          end

          it { is_expected.to eq :absent }
        end

        # Ensure absent: resource exists, ignore, no name, fail
        context 'title == name (fail)' do
          # TODO(nelsonjr): Implement new test format.
          subject { -> { raise '[placeholder] This should fail.' } }
          it { is_expected.to raise_error(RuntimeError, /placeholder/) }
        end
      end

      # Ensure absent: resource exists, ignore, has name
      context 'title != name' do
        # Ensure absent: resource exists, ignore, has name, pass
        context 'title != name (pass)' do
          before(:each) do
            expect_network_get_success 1
            expect_network_delete 1
            expect_network_get_async 1
          end

          subject do
            apply_compiled_manifest(
              <<-MANIFEST
              gcompute_https_health_check { 'title0':
                ensure     => absent,
                name       => 'test name#0 data',
                project    => 'test project#0 data',
                credential => 'cred0',
              }
              MANIFEST
            ).catalog.resource('Gcompute_https_health_check[title0]')
              .provider.ensure
          end

          it { is_expected.to eq :absent }
        end

        # Ensure absent: resource exists, ignore, has name, fail
        context 'title != name (fail)' do
          # TODO(nelsonjr): Implement new test format.
          subject { -> { raise '[placeholder] This should fail.' } }
          it { is_expected.to raise_error(RuntimeError, /placeholder/) }
        end
      end
    end
  end

  context '#flush' do
    subject do
      Puppet::Type.type(:gcompute_https_health_check).new(
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

  def expect_network_get_success(id, data = {})
    id_data = data.fetch(:name, '').include?('title') ? 'title' : 'name'
    body = load_network_result("success#{id}~#{id_data}.yaml").to_json

    request = double('request')
    allow(request).to receive(:send).and_return(http_success(body))

    expect(Google::Compute::Network::Get).to receive(:new)
      .with(self_link(uri_data(id).merge(data)),
            instance_of(Google::FakeAuthorization)) do |args|
      debug ">> GET #{args}"
      request
    end
  end

  def http_success(body)
    response = Net::HTTPOK.new(1.0, 200, 'OK')
    response.body = body
    response.instance_variable_set(:@read, true)
    response
  end

  def expect_network_get_async(id, data = {})
    body = { kind: 'compute#httpsHealthCheck' }.to_json

    request = double('request')
    allow(request).to receive(:send).and_return(http_success(body))

    expect(Google::Compute::Network::Get).to receive(:new)
      .with(self_link(uri_data(id).merge(data)),
            instance_of(Google::FakeAuthorization)) do |args|
      debug ">> GET <async> #{args}"
      request
    end
  end

  def expect_network_get_failed(id, data = {})
    request = double('request')
    allow(request).to receive(:send).and_return(http_failed_object_missing)

    expect(Google::Compute::Network::Get).to receive(:new)
      .with(self_link(uri_data(id).merge(data)),
            instance_of(Google::FakeAuthorization)) do |args|
      debug ">> GET [failed] #{args}"
      request
    end
  end

  def http_failed_object_missing
    Net::HTTPNotFound.new(1.0, 404, 'Not Found')
  end

  def expect_network_create(id, expected_body, data = {})
    body = { kind: 'compute#operation',
             status: 'DONE',
             targetLink: self_link(uri_data(id).merge(data)) }.to_json

    request = double('request')
    allow(request).to receive(:send).and_return(http_success(body))

    expect(Google::Compute::Network::Post).to receive(:new)
      .with(collection(uri_data(id).merge(data)),
            instance_of(Google::FakeAuthorization),
            'application/json', expected_body.to_json) do |args|
      debug ">> POST #{args} = body(#{body})"
      request
    end
  end

  def expect_network_delete(id, name = nil, data = {})
    delete_data = uri_data(id).merge(data)
    delete_data[:name] = name unless name.nil?
    body = { kind: 'compute#operation',
             status: 'DONE',
             targetLink: self_link(delete_data) }.to_json

    request = double('request')
    allow(request).to receive(:send).and_return(http_success(body))

    expect(Google::Compute::Network::Delete).to receive(:new)
      .with(self_link(delete_data),
            instance_of(Google::FakeAuthorization)) do |args|
      debug ">> DELETE #{args}"
      request
    end
  end

  def load_network_result(file)
    results = File.join(File.dirname(__FILE__), 'data', 'network',
                        'gcompute_https_health_check', file)
    debug("Loading result file: #{results}")
    raise "Network result data file #{results}" unless File.exist?(results)
    data = YAML.safe_load(File.read(results))
    raise "Invalid network results #{results}" unless data.class <= Hash
    data
  end

  def debug(message)
    puts(message) if ENV['RSPEC_DEBUG']
  end

  def create_type(id)
    Puppet::Type.type(:gcompute_https_health_check).new(
      ensure: :present,
      title: "title#{id - 1}",
      credential: "cred#{id - 1}",
      project: HHC_PROJECT_DATA[(id - 1) % HHC_PROJECT_DATA.size],
      name: HHC_NAME_DATA[(id - 1) % HHC_NAME_DATA.size]
    )
  end

  def expand_variables(template, data, extra_data = {})
    Puppet::Type.type(:gcompute_https_health_check).provider(:google)
                .expand_variables(template, data, extra_data)
  end

  def collection(data)
    URI.join(
      'https://www.googleapis.com/compute/v1/',
      expand_variables(
        'projects/{{project}}/global/httpsHealthChecks',
        data
      )
    )
  end

  def self_link(data)
    URI.join(
      'https://www.googleapis.com/compute/v1/',
      expand_variables(
        'projects/{{project}}/global/httpsHealthChecks/{{name}}',
        data
      )
    )
  end

  # Creates variable test data to comply with self_link URI parameters
  def uri_data(id)
    {
      project: HHC_PROJECT_DATA[(id - 1) % HHC_PROJECT_DATA.size],
      name: HHC_NAME_DATA[(id - 1) % HHC_NAME_DATA.size]
    }
  end
end
