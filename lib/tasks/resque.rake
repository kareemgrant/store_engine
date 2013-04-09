require "resque/tasks"

task "resque:setup" => :environment

Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection }
