require "spec_helper"

describe IssuecloserController, :type => :controller do

  render_views

  fixtures :issue_statuses

  before do
    @request.session[:user_id] = 1
    Setting.default_language = 'en'
    # Plugin settings are re-initialized in the controller # TODO Find a better way
    # Setting.plugin_issuecloser['issues_status_from'] = 1 # Resolved
    # Setting.plugin_issuecloser['issues_status_to'] = 5 # Closed
    # Setting.plugin_issuecloser['closing_note'] = "Closing the issue due to inactivity"
    # Setting.plugin_issuecloser['update_author'] = 1
  end

  context "GET :index" do

    it "should get main index page with issues to close" do
      get :index
      expect(Setting.plugin_issuecloser['issues_status_to']).to eq 5
      expect(response).to be_successful
      expect(response.body).to match /<h2>#{ I18n.t :label_issue_closer }<\/h2>/im
      expect(assigns(:issues_to_change)).to_not be_empty
      assigns(:issues_to_change).each do |issue|
        expect(Setting.plugin_issuecloser['issues_status_from']).to include issue.status_id
      end
    end

  end

end
