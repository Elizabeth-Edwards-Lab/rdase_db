# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "orth"
set :repo_url, "git@bitbucket.org:xcao2333/orthology_db.git"
set :deploy_to, '/apps/orth/project'
set :use_sudo, false
set :linked_files, ['config/database.yml']
set :linked_dirs, %w{tmp/tmp_fasta log}
set :keep_releases, 3

namespace :deploy do
  desc 'Start application'
  task :start do
    on roles(:web) do
      within release_path do
        execute "script/puma.sh", "start"
      end
    end
  end

  desc 'Stop application'
  task :stop do
    on roles(:web) do
      within release_path do
        execute "script/puma.sh", "stop"
      end
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:web) do
      within release_path do
        execute "script/puma.sh", "restart"
      end
    end
  end

  after :publishing, :restart, :cleanup
end


# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
