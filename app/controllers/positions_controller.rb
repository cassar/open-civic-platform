class PositionsController < ApplicationController
  def show
    @issue = Issue.find_by_id params[:issue_id]
    @position = Position.find_by_id params[:id]
    return unless user_signed_in?

    @support = current_user.supports.where_issue(@issue).find_by position: @position
  end
end
