require_dependency 'redmine_issue_closer/hooks'

Redmine::Plugin.register :issuecloser do
  name 'Issuecloser plugin'
  author 'Pavel Ishenin'
  description 'Close issues plugin'
  version '0.0.1'
  url 'https://github.com/isheninp/redmine_issue_closer'
  author_url 'https://github.com/isheninp'
  settings :partial => 'settings/issuecloser',
           :default => {
               :auto_close => false,
               :auto_close_after_days => 30,
           }
end

Redmine::MenuManager.map :admin_menu do |menu|
  menu.push :issuecloser, {:controller => 'issuecloser'},
            :after => :plugins,
            :caption => :label_issue_closer,
            :html => {:class => 'icon'}
end
