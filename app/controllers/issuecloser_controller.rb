class IssuecloserController < AdminController
  unloadable

  before_action :require_admin

  before_action :set_settings_for_test if Rails.env.test?

  layout 'admin'

  def index
    @issues_all_count = Issue.count
    @issues_to_change = Issue.where(status_id: Setting.plugin_issuecloser['issues_status_from']).
                              where("updated_on < ?", Setting.plugin_issuecloser['auto_close_after_days'].to_i.days.ago).
                              order(updated_on: :asc)
    @issues_to_change_count = @issues_to_change.count
    @issues_to_change_pages = Paginator.new @issues_to_change_count, per_page_option, params[:page]
    @issues_to_change_paginated = @issues_to_change.includes(:project, :tracker, :priority, :status)
                                      .limit(@issues_to_change_pages.per_page)
                                      .offset(@issues_to_change_pages.offset)
    @status_to = IssueStatus.find(Setting.plugin_issuecloser['issues_status_to'])
  end

  def update
    if params[:id]
      @issue = Issue.find(params[:id])
      if Setting.plugin_issuecloser['issues_status_from'].map(&:to_i).include? @issue.status_id
        if @issue.close(note: Setting.plugin_issuecloser['closing_note'],
                        user: User.current,
                        new_status_id: Setting.plugin_issuecloser['issues_status_to'])
          flash[:notice] = l(:notice_issue_status_updated)
        else
          flash[:error] = l(:error_issue_status_not_updated)
        end
      end
    end
    redirect_to :issuecloser
  end

  private

  def set_settings_for_test
    Setting.plugin_issuecloser['issues_status_from'] = [1, 3, 4] # New or Resolved
    Setting.plugin_issuecloser['issues_status_to'] = 5 # Closed
    Setting.plugin_issuecloser['closing_note'] = "Closing the issue due to inactivity"
    Setting.plugin_issuecloser['update_author'] = 1
    Setting.plugin_issuecloser['auto_close_after_days'] = 2
  end

end
