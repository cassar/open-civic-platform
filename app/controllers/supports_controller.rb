class SupportsController < ApplicationController
  before_action :authenticate_user!, :authorize_user!

  def toggle_subscription
    @support.toggle!(:subscribed)
    issue = @support.issue
    redirect_to group_issue_path(issue.group_id, issue),
      notice: 'Subscription updated'
  end

  private

  def authorize_user!
    @support= Support.find params[:id]
    return unless @support.user != current_user

    redirect_to root_path, alert: 'Subscription cannot be updated'
  end
end
