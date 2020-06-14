class Profile::IssuesController < ApplicationController
  before_action :authenticate_user!

  def show
    @issue = Issue.find_by_identifier params[:id]
    @positions = current_user.positions.where_issue(@issue)
    render 'issues/show'
  end
end
