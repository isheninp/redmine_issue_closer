module Issuecloser

  def self.install
    puts 'Issue closer is setting up, please wait...'

    #system 'bundle check || bundle install'

    puts 'Setting up schedule..'
    system 'wheneverize .' until File.exist?('config/schedule.rb')
    unless File.foreach('config/schedule.rb').grep(/issuecloser:close_tasks/).any?
      print 'Writing schedule config..'
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
      update_author = User.find(Setting.plugin_issuecloser['update_author'])
      new_status_id = Setting.plugin_issuecloser['issues_status_to']
      closing_note = Setting.plugin_issuecloser['closing_note']
      issues_to_change = Issue.where(status_id: Setting.plugin_issuecloser['issues_status_from'])
                             .where("updated_on < ?", Setting.plugin_issuecloser['auto_close_after_days'].to_i.days.ago)
                             .order(updated_on: :asc)
      issues_to_change.each do |issue|
        if issue.close(new_status_id: new_status_id,
                       user: update_author,
                       note: closing_note)
          puts 'Issue#' + issue.id.to_s + ' closed'
        end
      end
    else
      puts "#{I18n.t('label_issue_closer')}: #{I18n.t('label_disabled')}"
    end
  end

end
