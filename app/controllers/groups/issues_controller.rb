class Groups::IssuesController < GroupsController
  before_action :authenticate_user!
  before_action :authorize_user!

  def show
    @issue = Issue.find(params[:id])
  end

  def new
    @issue = @group.issues.new
  end

  def create
    @issue = @group.issues.new(issue_params)
    if @issue.save
      flash[:notice] = 'New issue created'
      redirect_to group_issue_path(@group, @issue)
    else
      flash[:alert] = @issue.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def issue_params
    params.require(:issue).permit(:name)
  end
end
