include_recipe "apache2"

php_pear "xdebug" do
  action :install
  not_if "sudo pear search xdebug | grep 'no packages found' "
end


bash "pecl_callback" do 
  code <<-EOH
    sudo pecl install xdebug
  EOH
  action :run
  not_if "echo `pear list|grep 'xdebug';pecl list|grep 'xdebug'` | grep 'xdebug'"
end

 

template "#{node['php']['ext_conf_dir']}/xdebug.ini" do
  source "xdebug.ini.erb"
  owner "root"
  group "root"
  mode "0644"
  action :create
  notifies :restart, "service[apache2]", :delayed
end