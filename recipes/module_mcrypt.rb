#
# Cookbook Name:: chef-php-extra
# Recipe:: module_mcrypt
#
# Copyright 2012, Alistair Stead
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

include_recipe "php"

if File.exists?("/etc/yum.repos.d/ius.repo")
    packages = %w{ php53u-mcrypt }
else
    packages = %w{ php-mcrypt }
end

pkgs = value_for_platform(
  [ "centos", "redhat", "fedora" ] => {
    "default" => packages
  },
  [ "debian", "ubuntu" ] => {
    "default" => %w{ php5-mcrypt }
  }
)

pkgs.each do |pkg|
  package pkg do
    action :install
  end
end

cookbook_file "#{node['php']['ext_conf_dir']}/mcrypt.ini" do
  owner "root"
  group "root"
  mode "0644"
  source "mcrypt.ini"
end