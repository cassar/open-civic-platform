class Issues::LinksController < LinksController
  private

  def linkable
    @linkable ||= Issue.find params[:issue_id]
  end

  def path_success
    issue_path(@linkable)
  end
end
