class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @profile = current_user.profile
    @supporting_issues = @profile.issues_supporting
  end
end
