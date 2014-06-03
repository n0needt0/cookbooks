# Add repositories for rabbitvcs
apt_repository "rabbitvcs" do
  uri "http://ppa.launchpad.net/rabbitvcs/ppa/ubuntu"
  distribution node['lsb']['codename']
  components ["main"]
end

# Reload package list through 'apt-get update'
include_recipe "apt::default"

# Install GUI
package "rabbitvcs-nautilus3" do
  action :install
end

#Install cli
package "rabbitvcs-cli" do
  action :install
end


 
