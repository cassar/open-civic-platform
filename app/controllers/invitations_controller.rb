class InvitationsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!

  def update
    if @invitation.accept_invitation
      redirect_to group_path(@invitation.group_id), notice: 'Group Joined'
    else
      flash[:alert] = 'Cannot accept invitation'
      redirect_to root_path
    end
  end

  def destroy
    if @invitation.destroy
      flash[:notice] = 'Invitation Declined'
      redirect_to groups_path
    else
      flash[:alert] = 'Cannot destroy invitation'
      redirect_to root_path
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
