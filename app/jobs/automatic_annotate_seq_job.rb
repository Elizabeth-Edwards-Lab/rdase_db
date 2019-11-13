# Active Job is a framework for declaring jobs and making them run on 
# a variety of queueing backends. These jobs can be everything from 
# regularly scheduled clean-ups, to billing charges, to mailings. 
# Anything that can be chopped up into small units of work and run in parallel, really.

# https://stackoverflow.com/questions/285717/a-cron-job-for-rails-best-practices
class AutomaticAnnotateSeqJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
  end
end
