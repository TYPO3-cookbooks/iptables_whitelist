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

actions :add
default_action :add

attribute :name,     :regex => /^[a-zA-Z0-9]+$/,  :required => true, :name_attribute => true
attribute :port,     :regex => /^[0-9]{2,5}$/,    :required => true
attribute :proto,    :kind_of => String,          :required => true, :equal_to => ["tcp", "udp"]
attribute :ip,      :kind_of => [String, Array],           :required => true