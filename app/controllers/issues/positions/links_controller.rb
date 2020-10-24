class Issues::Positions::LinksController < LinksController
  before_action :issue

  private

  def linkable
    @linkable ||= Position.find params[:position_id]
  end

  def path_success
    issue_position_path(issue, linkable)
  end

  def issue
    @issue ||= Issue.find params[:issue_id]
  end
end
