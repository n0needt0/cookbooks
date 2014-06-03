apt_repository "percona" do
  uri "http://repo.percona.com/apt"
  components ["main"]
  distribution node['lsb']['codename']
  keyserver "hkp://keys.gnupg.net:80"
  key "1C4CBDCDCD2EFD2A"
end

# Reload package list through 'apt-get update'
include_recipe "apt::default"

# Install percona toolkit
package "percona-toolkit" do
  action :install
end

#Manual fix key not found on a server issue
# wget -q http://www.percona.com/redir/downloads/RPM-GPG-KEY-percona
# gpg --import RPM-GPG-KEY-percona


