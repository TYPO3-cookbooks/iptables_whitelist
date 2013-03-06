#
# Cookbook Name:: iptables_whitelist
# Recipe:: default
#
# Copyright 2013, Steffen Gebert / TYPO3 Association
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

unless node[:iptables_whitelist].nil?

  include_recipe "simple_iptables"

  unless node[:iptables_whitelist][:tcp_port_by_role].nil? || node[:iptables_whitelist][:tcp_port_by_role].empty?

    node[:iptables_whitelist][:tcp_port_by_role].each do |dport, role|

      Chef::Log.debug "Searching for nodes matching role '#{role}' to white-list TCP port #{dport}"

      nodes = {}
      search(:node, "role:#{role}").reject{ |n| n[:ipaddress] == nil }.each do |n|
        nodes[n[:fqdn]] = n[:ipaddress]
      end

      Chef::Log.info "White-listing TCP port #{dport} for the following IP addresses based on role:#{role}:  " + nodes.sort.inspect

      iptables_whitelist_port "TCPPORT#{dport}" do
        proto "tcp"
        port dport
        ip nodes.values.sort
      end

    end

  end
end
