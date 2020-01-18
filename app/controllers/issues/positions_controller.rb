class Issues::PositionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!

  def new
    @position = @issue.positions.new
  end

  def show
    @position = Position.find params[:id]
    @support = Support.find_by(position: @positions, membership: current_user.memberships)
  end

  def create
    @position = @issue.positions.new(position_params)
    if @position.save
      flash[:notice] = 'Successfully Created Position'
      redirect_to group_issue_path @group, @issue
    else
      flash[:alert] = @position.errors.full_messages.to_sentence
      redirect_to :new
    end
  end

  private

  def position_params
    params.require(:position).permit(:name, :outline)
  end

  def authorize_user!
    @issue = Issue.find(params[:issue_id])
    @group = @issue.group
    return if @group.confirmed_profiles.include? current_user.profile

    redirect_to root_path, alert: 'Not able to interact with this group.'
  end
end
