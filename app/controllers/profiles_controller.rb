class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @profile = current_user.profile
    @memberships = current_user.confirmed_memberships.preload(:group)
    @invitations = current_user.invitations.preload(:group)
  end

  def edit
    @profile = current_user.profile
  end

  def update
    @profile = current_user.profile
    flash[:notice] = "Welcome #{@profile.name}!" if @profile.update(profile_params)
    redirect_to root_path
  end

  private

  def profile_params
    params.require(:profile).permit(:name)
  end
end
