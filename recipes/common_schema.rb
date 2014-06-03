remote_file "#{Chef::Config[:file_cache_path]}/common_schema-2.2.sql" do
  source "https://common-schema.googlecode.com/files/common_schema-2.2.sql"
  owner node[:user][:name]
  action :create_if_missing 
end


bash "install_commonschema" do 
  cwd "#{Chef::Config[:file_cache_path]}"
  code <<-EOH
    echo installing CommonSchema 2.2
    mysql -u root -p#{node['mysql']['server_root_password']} < common_schema-2.2.sql
  EOH
  action :run
end


