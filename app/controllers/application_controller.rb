class ApplicationController < ActionController::Base
  before_action :fill_in_name

  private

  def fill_in_name
    return unless user_signed_in? && current_user.profile.name.nil?
    return if controller_name == 'profiles'

    flash[:notice] = 'Please complete your profile below'
    redirect_to complete_profile_path
  end
end
