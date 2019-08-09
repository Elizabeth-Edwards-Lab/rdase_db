# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

set :output, { error: '/apps/orthdb/project/shared/log/whenever-error.log',
               standard: '/apps/orthdb/project/shared/log/whenever.log' }

# remove the temporary file that generated everyday
every :day, at: '12am' do
	runner "Cron.remove_tmp_fasta"
	runner "Cron.remove_tmp_csv"
end

# put the actual blast database creation for real crontab
# let user choose customized database or original database that depends on that three papers
