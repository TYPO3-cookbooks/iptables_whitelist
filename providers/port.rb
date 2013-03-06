#
# Cookbook Name:: iptables_whitelist
# Resource:: port
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

action :add do
  
  name  = new_resource.name
  proto = new_resource.proto
  port  = new_resource.port

  if new_resource.ip.kind_of?(String)
    ip = [new_resource.ip]
  else
    ip = new_resource.ip
  end

  Chef::Log.info "Adding iptables white-list for #{name}"

  if ip.empty?
    Chef::Log.warn "No IPs given to white-list #{name}"
    next
  end


  Chef::Log.info "White-listing rule #{name} allows the following IPs for port #{new_resource.port}: " +  ip.sort.inspect

  # ACCEPT all IPs
  ip.each do |ipaddress|
    simple_iptables_rule name do
      direction "INPUT"
      rule "--proto #{proto} --dport #{port} --src #{ipaddress}"
      jump "ACCEPT"
    end
  end

  # DROP everything else
  simple_iptables_rule name do
    direction "INPUT"
    rule "--proto #{proto} --dport #{port}"
    jump "DROP"
  end
end