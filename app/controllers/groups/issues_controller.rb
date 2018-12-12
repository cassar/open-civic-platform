class Groups::IssuesController < GroupsController
  before_action :authenticate_user!
  before_action :authorize_user!

  def show
    @issue = Issue.find(params[:id])
  end
end
