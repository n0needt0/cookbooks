
apt_repository "mariadb" do
  platform = node['platform']
  unless ['ubuntu'].include?(platform)
    raise "Unsupported platform: #{platform}"
  end
  uri "http://mirrors.supportex.net/mariadb/repo/#{node[:mariadb][:version]}/ubuntu"
  distribution node['lsb']['codename']
  components ['main']
  keyserver "hkp://keyserver.ubuntu.com:80"
  key "0xcbcb082a1bb943db"
  action :add
end

# Reload package list through 'apt-get update'
include_recipe "apt::default"

include_recipe "mysql::client"