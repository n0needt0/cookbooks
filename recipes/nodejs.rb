include_recipe "build-essential"
include_recipe "nodejs"
include_recipe "npm"

%w{ grunt-cli bower yo less csslint supervisor gulp karma}.each do |the_package|
  npm_package the_package
end	

# bower http://bower.io/
# csslint http://csslint.net/about.html	 	
# grunt-cli http://gruntjs.com/getting-started
# less https://github.com/less/less.js ,  http://lesscss.org/
# yo  http://yeoman.io/

# supervisor https://github.com/isaacs/node-supervisor
=begin
 due to npm porting issues to windows systems, makes useful sense for unixes only
if you are running nodejs on windows consider another approach
Dirty example: 

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

=end







