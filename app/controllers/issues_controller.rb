class IssuesController < ApplicationController
  before_action :check_published!, only: :show

  def index
    @issues = Issue.published.joins(:supports).uniq.take(12)
  end

  def show
    @positions = @issue.positions
    @links = @issue.links
    return unless user_signed_in?

    @adoption = current_user.adoptions.find_by issue: @issue
  end

  private

  def check_published!
    @issue = Issue.find params[:id]
    return if @issue.published

    redirect_to issues_path, alert: 'Issue not published'
  end
end
