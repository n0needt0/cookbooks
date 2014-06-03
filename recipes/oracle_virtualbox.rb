# Add repositories for webmin
apt_repository "virtualbox" do
  uri "http://download.virtualbox.org/virtualbox/debian"
  distribution node['lsb']['codename']
  components ["contrib"]
  key "http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc"
  action :add
end

# Reload package list through 'apt-get update'
include_recipe "apt::default"

# Install webmin
package "virtualbox-4.3" do
  action :install
end
