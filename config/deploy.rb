# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'geoip'
set :repo_url, 'git@github.com:wackadoo/psiori-geoip.git'
set :deploy_to, '/usr/share/nginx/geoip'

set :ssh_options, {
  forward_agent: true,
# port: 5775
}

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 10

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute :bundle, "exec thin -C config/thin_server.yml restart"
      end
    end
  end

  desc 'Start application'    
  task :start do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute :bundle, "exec thin -C config/thin_server.yml start"
      end
    end
  end
  
  desc 'Stop application'
  task :stop do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute :bundle, "exec thin -C config/thin_server.yml stop"
      end
    end
  end
  
  task :update_db do
    on roles(:db), in: :sequence do
      within release_path + "script/freegeoip_db" do
        with rails_env: fetch(:rails_env) do
          execute :bundle, "exec ./updatedb.rb"
        end
      end
    end
  end
  
  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
