module Issuecloser
  
  def self.install
    puts 'Issue closer is setting up, please wait...'
    
    #system 'bundle check || bundle install'
    
    puts 'Setting up schedule..'
    system 'wheneverize .' until File.exist?('config/schedule.rb')
    unless File.foreach('config/schedule.rb').grep(/issuecloser:close_tasks/).any?
      print 'Writing schedile config..'
      plugin_config = File.read("plugins/issuecloser/config/schedule.rb")
      File.open("config/schedule.rb", "a") do |config_file|
        config_file.puts plugin_config
      end
      puts 'ok'
    end
    system 'whenever --update-crontab'
    puts 'Done.'
  end
  
  def self.iclose
    if Setting.plugin_issuecloser['auto_close']
      issues_to_change=Issue.where('status_id=?', Setting.plugin_issuecloser['issues_status_from']).where("updated_on < ?", Setting.plugin_issuecloser['auto_close_after_days'].to_i.days.ago)
      issues_to_change.each do |i|
        Issue.find(i.id).update(status_id: Setting.plugin_issuecloser['issues_status_to'])
        p 'Issue#'+i.id.to_s+' closed'
      end      
    end
  end
  
end