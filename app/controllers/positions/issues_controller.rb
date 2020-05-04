class Positions::IssuesController < Issues::PositionsController
  after_action :new_issue_created, only: :create

  def new
    @issue = @group.issues.new
  end

  def create
    @issue = position.issues.new(issue_params)
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
    params.require(:issue).permit(:name).merge(group_id: @group.id)
  end

  def position
    @position ||= Position.find params[:position_id]
  end

  def group
    @group ||= position.group
  end

  def new_issue_created
    return unless @issue.save

    NewIssueNotification.new(current_user.profile, @group, @issue).notify!
  end
end
