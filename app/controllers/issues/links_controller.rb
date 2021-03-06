class Issues::LinksController < LinksController
  private

  def linkable
    @linkable ||= Issue.find params[:issue_id]
  end

  def path_success
    profile_issue_path(@linkable)
  end
end
