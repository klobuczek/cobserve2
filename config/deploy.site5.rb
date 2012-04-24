set :application, "cobserve2"
set :repository,  "svn://napoli.sinceritas.org/repos/trunk/cobserve2"

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
set :user, "sincerit"
#set :repository,  "URL_FOR_YOUR_REPOSITORY"
# SCM information
set :scm_username, "heinrich"
set :scm_password, Proc.new { CLI.password_prompt "SVN Password: "}
# This is related to site5 too.
set :deploy_to, "/home/#{user}/apps/#{application}"
role :app, "sinceritas.net"
role :web, "sinceritas.net"
role :db,  "sinceritas.net", :primary => true


# In the deploy namespace we override some default tasks and we define
# the site5 namespace.
namespace :deploy do
  desc <<-DESC
    Deploys and starts a `cold� application. This is useful if you have not \
    deployed your application before, or if your application is (for some \
    other reason) not currently running. It will deploy the code, run any \
    pending migrations, and then instead of invoking `deploy:restart�, it will \
    invoke `deploy:start� to fire up the application servers.  
  DESC
  # NOTE: we kill public_html so be sure to have a backup or be ok with this application  
  # being the default app for the domain.  
  task :cold do
    update    
    site5::link_public_html
    site5::make_executable
    site5::kill_dispatch_fcgi
  end
  
  desc <<-DESC
    Site5 version of restart task.  
  DESC
  task :restart do
    site5::kill_dispatch_fcgi
  end
  namespace :site5 do
    desc <<-DESC
    Links public_html to current_release/public
    DESC
    task :link_public_html do
      run "cd /home/#{user}; rm -rf public_html; ln -s #{current_path}/public ./public_html"
    end
    desc <<-DESC
    Make executable if comming from windows
    DESC
    task :make_executable do
      run "chmod -R 755 #{current_path}/*"
    end
    desc <<-DESC
      Kills Ruby instances on Site5
    DESC
    task :kill_dispatch_fcgi do
      run "skill -u #{user} -c ruby"
    end
  end
end 