DIRECTORIES = %w(/opt/solr4 /opt/solr4/data /usr/share/tomcat6-solr)

remote_file "#{Chef::Config[:file_cache_path]}/solr.tar.gz" do
  source "http://www.eu.apache.org/dist/lucene/solr/4.6.0/solr-4.6.0.tgz"
  owner node[:user][:name]
  action :create_if_missing
end


DIRECTORIES.each do | path |
  directory path do
    action :create
    owner 'tomcat6'
    group 'tomcat6'
  end
end


bash "unpack_solr" do 
  cwd "#{Chef::Config[:file_cache_path]}"
  code <<-EOH
    echo installing SOLR from #{Chef::Config[:file_cache_path]}
    tar -zxf #{Chef::Config[:file_cache_path]}/solr.tar.gz 
    mv #{Chef::Config[:file_cache_path]}/solr-*  #{Chef::Config[:file_cache_path]}/solr4
    sudo chown -R tomcat6:tomcat6 #{Chef::Config[:file_cache_path]}/solr4
  EOH
  action :run
end

bash "setup_share" do 
  cwd "#{Chef::Config[:file_cache_path]}"
  code <<-EOH
    sudo -u tomcat6 cp -r solr4/* /usr/share/tomcat6-solr/
    sudo  ln -f -s /usr/share/tomcat6-solr/dist/solrj-lib/* /usr/share/tomcat6/lib
  EOH
  action :run
end

bash "setup_example_catalog" do 
  cwd "#{Chef::Config[:file_cache_path]}"
  code <<-EOH
    sudo -u tomcat6 cp -r solr4/example/solr/* /opt/solr4    
  EOH
  action :run
end

template "/etc/tomcat6/Catalina/localhost/solr.xml" do
  source "solr.xml.erb"
  mode 0644
  owner 'tomcat6'
  group 'tomcat6'
end

template "/opt/solr4/collection1/conf/solrconfig.xml" do
  source "solrconfig.xml.erb"
  mode 0644
  owner 'tomcat6'
  group 'tomcat6'
end


include_recipe "java"
include_recipe "tomcat::users"
