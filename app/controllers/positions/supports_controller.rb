class Positions::SupportsController < ApplicationController
  before_action :authenticate_user!, :authorize_user!
  before_action :validate_update!, only: :update

  def create
    support = Support.create(position: @position, membership: @membership)
    if support.save
      flash[:notice] = 'Support Registered'
    else
      flash[:alert] = support.errors.full_messages.to_sentence
    end
    redirect_to group_issue_path(@group, @position.issue_id)
  end

  def destroy
    Support.find(params[:id]).destroy
    flash[:notice] = 'Support Withdrawn'
    redirect_to group_issue_path(@group, @position.issue_id)
  end

  def update
    old_position = @support.position
    if @support.update(position: @position)
      flash[:notice] = 'Support Shifted'
    else
      flash[:alert] = @support.errors.full_messages.to_sentence
    end
    redirect_to group_issue_path(@group, @position.issue_id)
  end

  private

  def authorize_user!
    @position = Position.find(params[:position_id])
    @group = @position.group
    @profile = current_user.profile
    @membership = Membership.find_by(group: @group, profile: @profile)
    return if @group.confirmed_memberships.include? @membership

    redirect_to root_path, alert: 'Not able to interact with this group.'
  end

  def validate_update!
    @support = Support.find(params[:id])
    return if @support.position_id != @position.id

    redirect_to group_issue_path(@group, @position.issue_id),
      alert: 'Already Support that Position'
  end
end
