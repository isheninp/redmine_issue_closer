class IssuecloserController < AdminController
  unloadable

  def index
    if params.has_key?(:id) && params[:issue_action]=='change' && (Issue.find(params[:id]).status_id.to_s==Setting.plugin_issuecloser['issues_status_from'])
      Issue.find(params[:id]).update(status_id: Setting.plugin_issuecloser['issues_status_to'])
    end      
    @issues_all_c=Issue.all
    @issues_to_change=Issue.where('status_id=?', Setting.plugin_issuecloser['issues_status_from']).where("updated_on < ?", Setting.plugin_issuecloser['auto_close_after_days'].to_i.days.ago).order(:created_on)
    @issues_to_change_c=@issues_to_change.count
    @issues_to_change_paginated=@issues_to_change.page params[:page]
  end

end
