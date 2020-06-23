class IssuesController < ApplicationController
  def index
    @issues = Issue.joins(:supports).uniq
  end

  def show
    @issue = Issue.find_by_identifier params[:id]
    @positions = @issue.positions
    return unless user_signed_in?

    @adoption = current_user.adoptions.find_by issue: @issue
  end
end
