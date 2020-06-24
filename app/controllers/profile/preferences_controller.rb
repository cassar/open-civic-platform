class Profile::PreferencesController < ApplicationController
  before_action :authenticate_user!, :authorize_user!

  def update
    PreferencesOrderer.new(@support, Integer(params[:preference])).order!
    redirect_to profile_issue_path(@support.issue),
      notice: 'Preference Updated'
  end

  private

  def authorize_user!
    @support = Support.find params[:id]
    return if @support.user == current_user

    redirect_to profile_path, alert: 'Support cannot be modified'
  end
end
