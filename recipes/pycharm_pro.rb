remote_file "#{Chef::Config[:file_cache_path]}/PyCharmPro.tar.gz" do
  source "http://download.jetbrains.com/python/pycharm-professional-3.0.2.tar.gz"
  owner node[:user][:name]
  action :create_if_missing
end

directory node[:developer_bootstrap][:apps_dir] do
  owner node[:user][:name]
  mode "0755"
  action :create
end

bash "install_pycharmpro" do 
  cwd "#{Chef::Config[:file_cache_path]}"
  code <<-EOH
    echo installing PyCharmPro from #{Chef::Config[:file_cache_path]}
    tar -zxf #{Chef::Config[:file_cache_path]}/PyCharmPro.tar.gz 
    mv #{Chef::Config[:file_cache_path]}/PyCharm*  #{Chef::Config[:file_cache_path]}/PyCharmPro
    mv #{Chef::Config[:file_cache_path]}/PyCharmPro #{node[:developer_bootstrap][:apps_dir]}/PyCharmPro    
    chown -R #{node[:user][:name]} #{node[:developer_bootstrap][:apps_dir]}/PyCharmPro 
  EOH
  action :run
end


template "#{node[:developer_bootstrap][:home_dir]}/Desktop/PyCharmPro.desktop" do
  source "desktop.erb"
  owner node[:user][:name]
  mode 0777
  variables({
     :Name => "RubyMine",
     :Exec => node[:developer_bootstrap][:apps_dir]+"/PyCharmPro/bin/pycharm.sh",
     :Icon => node[:developer_bootstrap][:apps_dir]+"/PyCharmPro/bin/webide.png",
     :Comment => "Develop with PyCharm!",
     :Categories => "Development;IDE;",
     :Terminal => "false",
     :StartupNotify => "true",
     :StartupWMClass => "jetbrains-pycharm"
  })
end

include_recipe "java"
