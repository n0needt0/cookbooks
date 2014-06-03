remote_file "#{Chef::Config[:file_cache_path]}/sublime-text.deb" do
  source "http://c758482.r82.cf2.rackcdn.com/sublime-text_build-3059_i386.deb"
  mode 0644
end

dpkg_package "sublime_text" do
  source "#{Chef::Config[:file_cache_path]}/sublime-text.deb"
  action :install
end
