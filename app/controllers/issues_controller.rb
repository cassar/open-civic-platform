class IssuesController < ApplicationController
  def index
    @issues = Issue.all
  end

  def show
    @issue = Issue.find_by_identifier params[:id]
    @positions = @issue.positions
  end
end
