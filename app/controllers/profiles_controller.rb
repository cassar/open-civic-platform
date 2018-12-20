class ProfilesController < ApplicationController
  before_action :authenticate_user!

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
