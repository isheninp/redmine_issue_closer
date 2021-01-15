## Redmine issue closing

### Description

Manual and automatic management of issues statuses

### To install:

Go to app folder and run:

```ruby
$ cd plugins && mkdir issuecloser && cd ..
```

Copy plugin files to folder /plugins/issuecloser

Redmine v.4 & Rails 5.2
```ruby
git clone --branch redmine-4 https://github.com/isheninp/redmine_issue_closer.git plugins/issuecloser
```
Redmine v.3 & Rails 4
```ruby
git clone --branch redmine-3 https://github.com/isheninp/redmine_issue_closer.git plugins/issuecloser
```

Do not change folder path!

Go to app folder and run:
```ruby
$ bundle check || bundle install
	
$RAILS_ENV=production bundle exec rake issuecloser:install
```

### Settings:
Automatic issue closing - to enable issue statuses updating automatically every day

Select projects (CTRL+) - find issues only in selected projects

Find status - find issue to be changed, for example "solved"

Set status to  - update issues with new status, for example "closed"

Wait before change status, days -  days since issue was UPDATED!

Note added to the issue when the status is updated - adds text to history

Author of automatic updates - who is author of updates

### License
MIT License. Copyright 2016-2017 isheninp@gmail.com

![C](http://www.google-analytics.com/collect?v=1&t=pageview&tid=UA-93741657-1)

