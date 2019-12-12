# frozen_string_literal: true

module Tcramer
  # Uses Rails generator functionality to write a rake task
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    def banner
      say_status('info', 'INSTALLING TCRAMER RAKE TASK AUTHOR', :blue)
    end

    def write_your_first_rake_task
      rakefile 'manage.rake' do
        %(
desc 'Manage all the things'
task :manage do
  puts Tcramer.manage
end
        )
      end
    end

    def write_your_second_rake_task
      rakefile 'motivate.rake' do
        %(
desc 'Motivate your employees'
task :motivate do
  puts Tcramer.motivate
end
        )
      end
    end
  end
end
