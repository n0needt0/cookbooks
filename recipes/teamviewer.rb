remote_file "#{Chef::Config[:file_cache_path]}/teamviewer_linux.deb" do
  source "http://download.teamviewer.com/download/teamviewer_linux.deb"
  mode 0644
end

dpkg_package "teamviewer" do
  source "#{Chef::Config[:file_cache_path]}/teamviewer_linux.deb"
  action :install
end
