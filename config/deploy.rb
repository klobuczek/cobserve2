require 'mongrel_cluster/recipes'
set :application, "cobserve2"
set :repository,  "svn://napoli.sinceritas.org/repos/trunk/cobserve2"
ssh_options[:port] = 22
#ssh_options[:verbose] = :debug
#ssh_options[:username] = 'remote-host-username'
#ssh_options[:host_key] = 'ssh-dss'
ssh_options[:keys] = %w(C:/keys/reno)

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
# set :deploy_to, "/var/www/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

#role :app, "your app-server here"
#role :web, "your web-server here"
#role :db,  "your db-server here", :primary => true


# Necessary to run on Site5
set :use_sudo, false
set :group_writable, false
# Less releases, less space wasted
set :keep_releases, 2
# The mandatory stuff
#set :application, "YOUR_APP_NAME"
set :user, "root"
#set :repository,  "URL_FOR_YOUR_REPOSITORY"
# SCM information
set :scm_username, "heinrich"
set :scm_password, Proc.new { CLI.password_prompt "SVN Password: "}
# This is related to site5 too.
set :deploy_to, "/var/www/#{application}"
set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"
role :app, "reno.sinceritas.org"
role :web, "reno.sinceritas.org"
role :db,  "reno.sinceritas.org", :primary => true
