class Groups::IssuesController < GroupsController
  before_action :authenticate_user!
  before_action :authorize_user!, except: :show
  before_action :authorize_user_show!, only: :show

  def show
    @membership = current_user.memberships.find_by group: @group
    @issue = Issue.find(params[:id])
    @positions = @issue.positions.preload(:supports)
  end

  def new
    @issue = @group.issues.new
  end

  def create
    @issue = @group.issues.new(issue_params)
    if @issue.save
      new_issue_created
    else
      flash[:alert] = @issue.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def issue_params
    params.require(:issue).permit(:name)
  end

  def new_issue_created
    NewIssueNotification.new(current_user.profile, @group, @issue).notify!
    redirect_to group_issue_path(@group, @issue),
      notice: 'New issue created'
  end
end
