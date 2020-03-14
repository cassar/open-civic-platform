class Issues::PositionsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!, except: :show
  before_action :authorize_user_show!, only: :show

  def new
    @position = @issue.positions.new
  end

  def show
    @membership = current_user.memberships.find_by group: @group
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
    return if group.confirmed_profiles.include? current_user.profile

    redirect_failed_authorization
  end

  def authorize_user_show!
    return if (
      group.confirmed_profiles | group.invited_profiles
    ).include? current_user.profile

    redirect_failed_authorization
  end

  def redirect_failed_authorization
    redirect_to root_path, alert: 'Not able to interact with this group.'
  end

  def issue
    @issue ||= Issue.find params[:issue_id]
  end

  def group
    @group ||= issue.group
  end
end
