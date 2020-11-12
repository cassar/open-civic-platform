class PositionsController < ApplicationController
  before_action :check_published!

  def show
    @issue = Issue.find_by_id params[:issue_id]
    @links = @position.links
    return unless user_signed_in?

    @support = current_user.supports.where_issue(@issue).find_by position: @position
  end

  private

  def check_published!
    @position = Position.find_by_id params[:id]
    return if @position.published

    redirect_to issues_path, alert: 'Position not published'
  end
end
