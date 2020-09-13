class IssuesController < ApplicationController
  def index
    @issues = Issue.joins(:supports).uniq.take(12)
  end

  def show
    @issue = Issue.find_by_id params[:id]
    @positions = @issue.positions
    return unless user_signed_in?

    @adoption = current_user.adoptions.find_by issue: @issue
  end
end
