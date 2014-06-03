template "#{node['php']['ext_conf_dir']}/php_devbox.ini" do
  source "devbox.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
  notifies :restart, "service[apache2]", :delayed
end