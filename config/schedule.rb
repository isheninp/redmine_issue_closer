# Close unclosed issues
every 1.day, :at => '4:30 am' do
   rake 'issuecloser:close_tasks'
end