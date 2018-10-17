class IssuecloserController < AdminController
  unloadable

  def index
    if params.has_key?(:id) && params[:issue_action] == 'change' && (Issue.find(params[:id]).status_id.to_s == Setting.plugin_issuecloser['issues_status_from'])
      Issue.find(params[:id]).update(status_id: Setting.plugin_issuecloser['issues_status_to'])
    end
    @issues_all_count = Issue.count
    @issues_to_change = Issue.where('status_id=?', Setting.plugin_issuecloser['issues_status_from']).where("updated_on < ?", Setting.plugin_issuecloser['auto_close_after_days'].to_i.days.ago).order(:created_on)
    @issues_to_change_count = @issues_to_change.count
    @issues_to_change_paginated = @issues_to_change.includes(:project, :tracker, :priority, :status).page params[:page]
    @status_to = IssueStatus.find(Setting.plugin_issuecloser['issues_status_to'])
  end

end
