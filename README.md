# Summary #
Helper CHEF repository for my devbox box configuration. Suitable for:

- LAMP
- MEAN stack
- Java stack


## Attributes ##

**node[:user][:name]**

Requires you to specify name of the user for whom we are installing

**default[:developer_bootstrap][:home_dir]**

User's home folder, by default


*default[:developer_bootstrap][:home_dir] = '/home/'+node[:user][:name]*


**default[:developer_bootstrap][:apps_dir]**

Directory where user software will be installed, by default


default[:developer_bootstrap][:apps_dir] = default[:developer_bootstrap][:home_dir] + "/apps"


## Recipes ##

###apache_solr4
Performs default setup of the SOLR 4.6.0;  Reuses tomcat cookbook.
For best results with chef-solo, override ssl passwords in environment:
<pre>
 "override_attributes":{
      "tomcat" : {
                   "keystore_password": "devroot",
                    "truststore_password": "devroot"
                  }                 

    }
</pre>

also make sure that you have tomcat_users databag in place so the recipe could configure tomcat users rights.
Example of the databag item:
<pre>
{
  "id": "root",
  "password": "devroot",
  "roles": [
    "manager",
    "admin"
  ]
}
</pre>


###common_schema
Installs DBA framework Common_Schema 2.2  [http://code.openark.org/blog/mysql/common_schema-2-2-better-queryscript-isolation-tokudb-table_rotate-split-params](http://code.openark.org/blog/mysql/common_schema-2-2-better-queryscript-isolation-tokudb-table_rotate-split-params) , requires MySQL/MariaDB/Percona to be installed.

Check usage options: [http://www.percona.com/live/london-2013/sites/default/files/slides/common_schema-pllondon-2013_0.pdf](http://www.percona.com/live/london-2013/sites/default/files/slides/common_schema-pllondon-2013_0.pdf)


###default
gpick - color picker,
xclip - console operations with clipboard, mc - midnight commander, htop - handy process monitor, nautilus-open-terminal - menu item to open current folder in terminal, rabbitVCS - gui for git/SVN/mercurial


### googlechrome
Stable google chrome browser

### ideaj
IntelliJ IDEA — The Best Java and Polyglot IDE, community edition


### ideaj_pro
IntelliJ IDEA — The Best Java and Polyglot IDE, pro (trial) edition

### mailcatcher
Debug tool to catch emails send from the box. Nicely mocks sendmail and SMTP servers.
[http://mailcatcher.me/](http://mailcatcher.me/)
Web interface available on port **1080**

### mariadb_client
Client packages for mariaDB, note: requires appropriate environment settings:
<pre>
  "mariadb": {
                   "version":"5.5"
                },
     "mysql" :  {
                   "use_upstart": false,
                   "server_root_password": "devroot",
                   "server_repl_password": "devrepl",
                   "server_debian_password": "devdebian",                   
                   "client": {
                                "packages":["mariadb-client", "libmariadbclient-dev"]
                             },
                   "server": {
                                "packages":["mariadb-server"]
                             }          
                }

</pre>

###mariadb_server
MariaDB server (MySQL compatible) - see notes for **mariadb_client**

###nodejs
Installs nodejs + set of modules.
For nodejs in the environment file you have an ability to specify version hints:
<pre>
   "nodejs": {
                  "install_method":"source",
                  "version":"0.10.24",
                  "checksum":"610cd733186842cb7f554336d6851a61b2d3d956050d62e49fa359a47640377a",
                  "checksum_linux_x64":"6ef93f4a5b53cdd4471786dfc488ba9977cb3944285ed233f70c508b50f0cb5f",
                  "checksum_linux_x86":"fb6487e72d953451d55e28319c446151c1812ed21919168b82ab1664088ecf46",
                  "dir":"/usr/local",
                  "npm":"1.3.9",
                  "src_url":"http://nodejs.org/dist",
                  "legacy_packages":false
                }           
</pre>

NodeJS modules installed with this recipe:

* bower http://bower.io/
* csslint http://csslint.net/about.html	 	
* grunt-cli http://gruntjs.com/getting-started
* less https://github.com/less/less.js ,  http://lesscss.org/
* yo  http://yeoman.io/
* supervisor https://github.com/isaacs/node-supervisor

Note: due to npm porting issues to windows systems, supervisor makes useful sense for unixes only
if you are running nodejs on windows consider another approach
Dirty example: 
<pre>
gem install watchr
watchr .watchr	
where .watchr

RUN_COMMAND = "node server.js > server.log"
KILL_COMMAND = "taskkill /IM node.exe /f"
 
puts "starting server"
io = IO.popen(RUN_COMMAND)
 
watch("^.*\.js$") do |match|  
    system KILL_COMMAND
    puts "restarting server"
    io = IO.popen(RUN_COMMAND)
end
</pre>

###oracle_virtualbox
This recipe is intended to use on host computer only. it installs Oracle VirtualBox 4.3 https://www.virtualbox.org/
In combination with Vagrant this tool can be used for virtual development environments provision.

###percona_toolkit
Percona Toolkit for MySQL is a collection of advanced command-line tools used by Percona MySQL Support staff to perform a variety of MySQL server and system tasks that are too difficult or complex to perform manually, including:

- Verify master and replica data consistency
- Efficiently archive rows
- Find duplicate indexes
- Summarize MySQL servers
- Analyze queries from logs and tcpdump
- Collect vital system information when problems occur

More: [http://www.percona.com/doc/percona-toolkit/2.2/](http://www.percona.com/doc/percona-toolkit/2.2/)

Note: from time to type you can experience situation, that key server is temporary down. In this case, you can add the key manually:
<pre>
wget -q http://www.percona.com/redir/downloads/RPM-GPG-KEY-percona
gpg --import RPM-GPG-KEY-percona
</pre>

### php_webgrind
Webgrind is a Xdebug profiling web frontend in PHP5. It implements a subset of the features of kcachegrind and installs in seconds and works on all platforms

- Super simple, cross platform installation - obviously :)
- Track time spent in functions by self cost or inclusive cost. Inclusive cost is time inside function + calls to other functions.
- See if time is spent in internal or user functions.
- See where any function was called from and which functions it calls.
- Generate a call graph using gprof2dot.py

[https://github.com/jokkedk/webgrind](https://github.com/jokkedk/webgrind)

### php_xdebug
Debug extension for PHP

### phpmyadmin

Classic web frontend for mysql, available at /phpmyadmin/ virtual folder

###phpstorm
Jetbrains IDE for PHP development

### pycharm 
Jetbrains IDE for python development, community edition, classic python only

### pycharm_pro
Jetbrains IDE for pythin development, professional edition, modern python frameworks support

### rabbitvcs
GUI for git, subversion, mercurial. Smth like TortoiseSVN/TortoiseGit on windows box

### rubymine
Jetbrains IDE for ruby development

### sublime_text
Evaluation of the handy crossplatform developer friendly editor (beta version of the SublimeText3)

### teamviewer
Remote access to your box (non commercial use only)


###vagrant
In combination with VirtualBox this tool can be used for virtual development environments provision.
See [http://docs.vagrantup.com/v2/why-vagrant/index.html](http://docs.vagrantup.com/v2/why-vagrant/index.html) for more details

### webmin
Best web based administration tool for managing your servers without console.

# How to use #

See [https://github.com/Voronenko/chef-developer_bootstrap](https://github.com/Voronenko/chef-developer_bootstrap)



#Linked projects: #

Interested in pure Chef template?
See [https://github.com/Voronenko/chef-developer_bootstrap](https://github.com/Voronenko/chef-developer_bootstrap)

Interested in using developer box Chef recipes in your own cookbooks?
See [https://github.com/Voronenko/chef-developer_recipes](https://github.com/Voronenko/chef-developer_recipes)

Interested in building your devbox on top of Vagrant + vagrant-berkshelf plugin?
See [https://github.com/Voronenko/vagrant-wrap](https://github.com/Voronenko/vagrant-wrap)


Note: see following article about future of the vagrant-berkshelf plugin [https://sethvargo.com/the-future-of-vagrant-berkshelf/](https://sethvargo.com/the-future-of-vagrant-berkshelf/)

Interested in building your devbox on top of Vagrant + test-kitchen?
See [https://github.com/Voronenko/lamp-kitchen](https://github.com/Voronenko/lamp-kitchen) 