class MembershipsController < ApplicationController
  before_action :authenticate_user!

  def update
    @membership = Membership.find(params[:id])
    if @membership.invitee? && @membership.user_id == current_user.id
      @membership.accept_invitation
      redirect_to group_path(@membership.group_id), notice: 'Group Joined'
    else
      flash[:alert] = 'Cannot Update Membership'
      redirect_to root_path
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
    if @membership.user_id == current_user.id
      @membership.destroy
      flash[:notice] = destroy_notice_message
      redirect_to groups_path
    else
      flash[:alert] = 'Cannot Destroy Membership'
      redirect_to root_path
    end
  end

  private

  def destroy_notice_message
    if @membership.invitee?
      'Invitation Declined'
    else
      'Left Group'
    end
  end
end
