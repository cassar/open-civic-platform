class MembershipsController < ApplicationController
  before_action :authenticate_user!, :authorize_user!

  def destroy
    if @membership.destroy
      flash[:notice] = 'Left group'
      redirect_to groups_path
    else
      flash[:alert] = 'Cannot leave group'
      redirect_to root_path
    end
  end

  def toggle_subscription
    @membership.toggle!(:subscribed)
    redirect_to group_path(@membership.group_id), notice: 'Subscription updated'
  end

  private

  def authorize_user!
    @membership = Membership.find(params[:id])
    return if current_user.profile.id == @membership.profile_id
    return if @membership.confirmed?

    redirect_to root_path, alert: 'Not able to modify this membership.'
  end
end
