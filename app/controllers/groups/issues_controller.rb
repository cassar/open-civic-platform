class Groups::IssuesController < GroupsController
  before_action :authenticate_user!
  before_action :authorize_user!, except: :show
  before_action :authorize_user_show!, only: :show

  after_action :notify_group, only: :create

  def show
    @membership = current_user.memberships.find_by group: @group
    @issue = Issue.find(params[:id])
    @position = @issue.position
    @positions = @issue.positions.preload(:supports)
    @support = @issue.supports.find_by(membership: @membership)
  end

  def new
    @issue = @group.issues.new
  end

  def create
    @issue = @group.issues.new(issue_params)
    if @issue.save
      redirect_to group_issue_path(@group, @issue),
        notice: 'New issue created'
    else
      flash[:alert] = @issue.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def issue_params
    params.require(:issue).permit(:name)
  end

  def notify_group
    return unless @issue.save

    NewIssueNotification.new(current_user.profile, @group, @issue).notify!
  end
end
