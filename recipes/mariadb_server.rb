existingversion = `dpkg -s mariadb-server | grep Version:`

if !existingversion.empty?
  log "MariaDB already installed: " + existingversion
  return
end

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

include_recipe "mysql::server"

#Eliminate once ticket https://tickets.opscode.com/browse/COOK-3974 is resolved
template '/etc/mysql/debian.cnf' do
  source 'debian.cnf.erb'
  owner 'root'
  group 'root'
  mode '0600'
end

