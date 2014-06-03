chrome_installed = `which google-chrome`
if chrome_installed.empty?

apt_repository "googlechrome" do
  uri "http://dl.google.com/linux/chrome/deb/"
  distribution "stable" #node['lsb']['codename']
  components ["main"]
  key "https://dl-ssl.google.com/linux/linux_signing_key.pub"
  action :add
end


# Reload package list through 'apt-get update'
include_recipe "apt::default"

# Install chrome stable
package "google-chrome-stable" do
  action :install
end

end


