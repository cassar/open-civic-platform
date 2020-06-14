class Profile::IssuesController < ApplicationController
  before_action :authenticate_user!

  def show
    @issue = Issue.find_by_identifier params[:id]
    position_ids = current_user.supports.where(issue: @issue).pluck(:position_id)
    @positions = Position.where(id: position_ids)
    render 'issues/show'
  end
end
