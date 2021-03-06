#
# Author:: Jesse Proudman (<jesse.proudman@blueboxgrp.com>)
# Copyright:: Copyright (c) 2010 Blue Box Group
# License:: Apache License, Version 2.0
#
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
#

require 'chef/knife'

class Chef
  class Knife
    class BlueboxFlavorList < Knife

      deps do
        require 'fog'
        require 'terminal-table'
        require 'chef/json_compat'
      end

      banner "knife bluebox flavor list"

      def run
        bluebox = Fog::Compute::Bluebox.new(
          :bluebox_customer_id => Chef::Config[:knife][:bluebox_customer_id],
          :bluebox_api_key => Chef::Config[:knife][:bluebox_api_key]
        )

        table = Terminal::Table.new do |t|

          t << [ 'ID', 'Description']
          t << :separator          

          bluebox.flavors.each do |flavor|
            t << Array.new.tap do |a|
              a << flavor.id.to_s
              a << flavor.description
            end
          end
        end

        puts table
        
      end
    end
  end
end
