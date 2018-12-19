class Positions::SupportsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!

  def create
    membership = Membership.find_by(group: @group, profile: current_user.profile)
    support = Support.create(position: @position, membership: membership)
    if support.save
      flash[:notice] = 'Support Registered'
    else
      flash[:alert] = support.errors.full_messages.to_sentence
    end
    redirect_to group_issue_path(@group, @position.issue_id)
  end

  def destroy
    support = Support.find(params[:id])
    support.destroy
    flash[:notice] = 'Support Withdrawn'
    redirect_to group_issue_path(@group, @position.issue_id)
  end

  def update
    support = Support.find(params[:id])
    if support.update(position: @position)
      flash[:notice] = 'Support Registered'
    else
      flash[:alert] = support.errors.full_messages.to_sentence
    end
    redirect_to group_issue_path(@group, @position.issue_id)
  end

  private

  def authorize_user!
    @position = Position.find(params[:position_id])
    @group = @position.group
    return if @group.confirmed_profiles.include? current_user.profile

    redirect_to root_path, alert: 'Not able to interact with this group.'
  end
end
