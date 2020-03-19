class InvitationsController < ApplicationController
  before_action :authenticate_user!, :authorize_user!

  def update
    if @invitation.accept_invitation
      NewMemberNotification.new(current_user.profile, Group.find(@invitation.group_id)).notify_accepted!
      redirect_to group_path(@invitation.group_id), notice: 'Group Joined'
    else
      redirect_to root_path, alert: 'Cannot accept invitation'
    end
  end

  def destroy
    if @invitation.destroy
      redirect_to groups_path, notice: 'Invitation Declined'
    else
      redirect_to root_path, alert: 'Cannot destroy invitation'
    end
  end

  private

  def authorize_user!
    @invitation = Membership.find(params[:id])
    return if current_user.profile.id == @invitation.profile_id
    return if @invitation.invited?

    redirect_to root_path, alert: 'Not able to modify this invitation.'
  end
end
