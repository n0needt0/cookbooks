remote_file "#{Chef::Config[:file_cache_path]}/RubyMine.tar.gz" do
  source "http://download.jetbrains.com/ruby/RubyMine-6.0.1.tar.gz"
  owner node[:user][:name]
  action :create_if_missing 
end

directory node[:developer_bootstrap][:apps_dir] do
  owner node[:user][:name]
  mode "0755"
  action :create
end

bash "install_rubymine" do 
  cwd "#{Chef::Config[:file_cache_path]}"
  code <<-EOH
    echo installing RubyMine from #{Chef::Config[:file_cache_path]}
    tar -zxf #{Chef::Config[:file_cache_path]}/RubyMine.tar.gz 
    mv #{Chef::Config[:file_cache_path]}/RubyMine*  #{Chef::Config[:file_cache_path]}/RubyMine
    mv #{Chef::Config[:file_cache_path]}/RubyMine #{node[:developer_bootstrap][:apps_dir]}/RubyMine    
    chown -R #{node[:user][:name]} #{node[:developer_bootstrap][:apps_dir]}/RubyMine 
  EOH
  action :run
end


template "#{node[:developer_bootstrap][:home_dir]}/Desktop/RubyMine.desktop" do
  source "desktop.erb"
  owner node[:user][:name]
  mode 0777
  variables({
     :Name => "RubyMine",
     :Exec => node[:developer_bootstrap][:apps_dir]+"/RubyMine/bin/runymine.sh",
     :Icon => node[:developer_bootstrap][:apps_dir]+"/RubyMine/bin/webide.png",
     :Comment => "Develop with RubyMine!",
     :Categories => "Development;IDE;",
     :Terminal => "false",
     :StartupNotify => "true",
     :StartupWMClass => "jetbrains-rubymine"
  })
end

include_recipe "java"
