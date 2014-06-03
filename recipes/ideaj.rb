remote_file "#{Chef::Config[:file_cache_path]}/IdeaJ.tar.gz" do
  source "http://download.jetbrains.com/idea/ideaIC-13.0.1.tar.gz"
  owner node[:user][:name]
  action :create_if_missing
end

directory node[:developer_bootstrap][:apps_dir] do
  owner node[:user][:name]
  mode "0755"
  action :create
end

bash "install_idea" do 
  cwd "#{Chef::Config[:file_cache_path]}"
  code <<-EOH
    echo installing IdeaJ from #{Chef::Config[:file_cache_path]}
    tar -zxf #{Chef::Config[:file_cache_path]}/IdeaJ.tar.gz 
    mv #{Chef::Config[:file_cache_path]}/idea-IC*  #{Chef::Config[:file_cache_path]}/ideaIC
    mv #{Chef::Config[:file_cache_path]}/ideaIC #{node[:developer_bootstrap][:apps_dir]}/ideaIC    
    chown -R #{node[:user][:name]} #{node[:developer_bootstrap][:apps_dir]}/ideaIC 
  EOH
  action :run
end


template "#{node[:developer_bootstrap][:home_dir]}/Desktop/Idea.desktop" do
  source "desktop.erb"
  owner node[:user][:name]
  mode 0777
  variables({
     :Name => "Idea",
     :Exec => node[:developer_bootstrap][:apps_dir]+"/ideaIC/bin/idea.sh",
     :Icon => node[:developer_bootstrap][:apps_dir]+"/ideaIC/bin/idea.png",
     :Comment => "Develop with Idea!",
     :Categories => "Development;IDE;",
     :Terminal => "false",
     :StartupNotify => "true",
     :StartupWMClass => "jetbrains-idea"
  })
end

include_recipe "java"
