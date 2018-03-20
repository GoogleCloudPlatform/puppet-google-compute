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

require 'google/compute/network/get'

module Google
  module Compute
    module Api
      # A helper class to serialize an instance into a Puppet manifest.
      # rubocop:disable Metrics/ClassLength
      class InstanceManifest
        def initialize(name, zone, project, cred, cred_path)
          @name = name
          @zone = zone
          @project = project
          @cred = cred
          @cred_path = cred_path
        end

        def generate(output_file)
          result = [
            marker('Authentication'),
            generate_auth,
            marker('Zones'),
            generate_zone,
            marker('Networks'),
            generate_networks,
            marker('Disks'),
            generate_disks,
            marker('Instance'),
            generate_instance
          ].map { |r| r.join("\n") }
          open(output_file, 'w') { |out| out << result.join("\n\n") + "\n" }
        end

        private

        # rubocop:disable Metrics/MethodLength
        def generate_instance
          [
            "gcompute_instance { '#{instance['name']}':",
            '  ensure             => present,',
            '  disks              => [',
            instance['disks'].map do |disk|
              [
                '    {',
                '      auto_delete => true,',
                ('      boot        => true,' if disk['boot']),
                "      source      => '#{disk['source'].split('/').last}',",
                '    },'
              ].compact
            end,
            '  ],',
            '  network_interfaces => [',
            instance['networkInterfaces'].map do |nic|
              [
                '    {',
                "      network        => '#{nic['network'].split('/').last}',",
                '      access_configs => [',
                '        {',
                "          name => 'External NAT',",
                "          type => 'ONE_TO_ONE_NAT',",
                '        },',
                '      ],',
                '    }'
              ]
            end,
            '  ],',
            "  zone               => '#{@zone}',",
            "  project            => '#{@project}',",
            "  credential         => 'mycred',",
            '}'
          ]
        end
        # rubocop:enable Metrics/MethodLength

        def generate_disks
          instance['disks'].map do |data|
            disk = disk(URI.parse(data['source']))
            image = disk['sourceImage'].split('/')
            [
              "gcompute_disk { '#{disk['name']}':",
              '  ensure       => present,',
              "  size_gb      => #{disk['sizeGb']}",
              '  source_image =>', "    gcompute_image_family('#{image[9]}',",
              "                          '#{image[6]}'),",
              "  zone         => '#{data['source'].split('/')[8]}',",
              "  project      => '#{@project}',",
              "  credential   => 'mycred',",
              '}'
            ]
          end
        end

        def generate_networks
          instance['networkInterfaces']
            .map { |nic| nic['network'] }
            .uniq
            .map do |network|
              [
                "gcompute_network { '#{network.split('/').last}':",
                '  ensure     => present,',
                "  project    => '#{@project}',",
                "  credential => 'mycred',",
                '}'
              ]
            end
        end

        def generate_zone
          [
            "gcompute_zone { '#{instance['zone'].split('/').last}':",
            "  project    => '#{@project}',",
            "  credential => 'mycred',",
            '}'
          ]
        end

        def generate_auth
          [
            'gauth_credential { \'mycred\':',
            "  path     => '#{@cred_path}',",
            '  provider => serviceaccount,',
            '  scopes   => [',
            "    'https://www.googleapis.com/auth/compute',",
            '  ],',
            '}'
          ]
        end

        def marker(title)
          [
            "##{'-' * 60}",
            "# #{title}",
            "##{'-' * 60}"
          ]
        end

        def instance
          @instance ||= begin
            self_link = Puppet::Type.type(:gcompute_instance).provider(:google)
                                    .self_link(name: @name, zone: @zone,
                                               project: @project)

            request = ::Google::Compute::Network::Get.new(self_link, @cred)
            response = JSON.parse(request.send.body)
            raise Puppet::Error, response['error']['errors'][0]['message'] \
               if response['error']
            response
          end
        end

        def disk(self_link)
          request = ::Google::Compute::Network::Get.new(self_link, @cred)
          response = JSON.parse(request.send.body)
          raise Puppet::Error, response['error']['errors'][0]['message'] \
             if response['error']
          response
        end
      end
      # rubocop:enable Metrics/ClassLength
    end
  end
end
