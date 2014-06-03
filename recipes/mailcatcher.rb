#http://mailcatcher.me/
#thanks for tool to https://github.com/r8/vagrant-lamp

package "libsqlite3-dev"

gem_package "mailcatcher" do
  options("--no-ri --no-rdoc")
end


bash "mailcatcher" do
  code "mailcatcher --http-ip 0.0.0.0 --smtp-port 25"
  not_if "ps ax | grep -v grep | grep mailcatcher";
end

template "#{node['php']['ext_conf_dir']}/mailcatcher.ini" do
  source "mailcatcher.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
  notifies :restart, "service[apache2]", :delayed
end


template "/etc/init.d/mailcatcher.sh" do
  source "mailcatcher.sh.erb"
  owner "root"
  group "root"
  mode "0755"
  action :create
end



