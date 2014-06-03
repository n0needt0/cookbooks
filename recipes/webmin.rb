# Add repositories for webmin
apt_repository "webmin1" do
  uri "http://download.webmin.com/download/repository"
  distribution "sarge" #node['lsb']['codename']
  components ["contrib"]
  key "http://www.webmin.com/jcameron-key.asc"
  action :add
end

apt_repository "webmin2" do
  uri "http://webmin.mirror.somersettechsolutions.co.uk/repository"
  distribution "sarge" #node['lsb']['codename']
  components ["contrib"]
  key "http://www.webmin.com/jcameron-key.asc"
  action :add
end

# Reload package list through 'apt-get update'
include_recipe "apt::default"

# Install webmin
package "webmin" do
  action :install
end
