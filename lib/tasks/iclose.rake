namespace :issuecloser do
  
  # bundle exec rake issuecloser:install
  desc "Install"
  task install: :environment do
    Issuecloser::install
  end
  
  # bundle exec rake issuecloser:close_tasks
  desc "Close tasks"
  task close_tasks: :environment do
    Issuecloser::iclose
  end
end