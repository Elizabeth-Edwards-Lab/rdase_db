threads 1, 4
workers 3
#environment 'production'
environment 'development'
stdout_redirect 'log/puma.log', 'log/puma_error.log', true
preload_app!

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end

before_fork do
  require 'puma_worker_killer'

  PumaWorkerKiller.config do |config|
    config.ram           = 512 # MB
      # According to Nate Berkopec, https://confreaks.tv/videos/rubyconf2016-halve-your-memory-usage-with-these-12-weird-tricks
      # a Puma worker will typically use ~300 MB of RAM, or 600 MB on the high end. In
      # MolDB at the time PumaWorkerKiller was added, we had very memory-inefficient
      # actions using up to 1-3 GB of memory, so worker memory could increase rapidly,
      # even to 14-16 GB until the OS would start killing processes. To try to avoid
      # interrupting memory-inefficient actions, we here set the memory limit quite high
      # at 6 GB, but once code memory efficiency is improved this limit could be reduced.
    config.frequency     = 60    # seconds
    config.percent_usage = 0.98
    #config.rolling_restart_frequency = 12 * 3600 # 12 hours in seconds
      # Disable rolling restart since I suspect it may have led to MolDB crashing
      #   -- David Arndt
    config.reaper_status_logs = true # setting this to false will not log lines like:
    # PumaWorkerKiller: Consuming 54.34765625 mb with master and 2 workers.
  end
  PumaWorkerKiller.enable_rolling_restart
  PumaWorkerKiller.start
end
