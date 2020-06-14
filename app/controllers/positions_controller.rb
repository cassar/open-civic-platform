class PositionsController < ApplicationController
  def show
    @issue = Issue.find_by_identifier params[:issue_id]
    @position = Position.find_by_identifier params[:id]
  end
end
