class Positions::SupportsController < ApplicationController
  before_action :authenticate_user!, :authorize_user!
  before_action :validate_update!, only: :update

  after_action :notify_shifted, only: :update

  def create
    support = Support.create(position: @position, membership: @membership)
    if support.save
      SupportNotifications.new(**base_notification_params)
        .notify_registered!
      flash[:notice] = 'Support Registered'
    else
      flash[:alert] = support.errors.full_messages.to_sentence
    end
    redirect_to issue_position_path(@position.issue, @position)
  end

  def destroy
    Support.find(params[:id]).destroy
    SupportNotifications.new(**base_notification_params)
      .notify_withdrawn!
    flash[:notice] = 'Support Withdrawn'
    redirect_to issue_position_path(@position.issue, @position)
  end

  def update
    @old_position = @support.position
    if @support.update(position: @position)
      flash[:notice] = 'Support Shifted'
    else
      flash[:alert] = @support.errors.full_messages.to_sentence
    end
    redirect_to issue_position_path(@position.issue, @position)
  end

  private

  def authorize_user!
    @position = Position.find(params[:position_id])
    @group = @position.group
    @profile = current_user.profile
    @membership = Membership.find_by(group: @group, profile: @profile)
    return if @group.confirmed_memberships.include? @membership

    redirect_to root_path, alert: 'Not able to interact with this group.'
  end

  def notify_shifted
    return unless flash[:notice].present?

    SupportNotifications.new(**base_notification_params, old_position: @old_position)
      .notify_shifted!
  end

  def validate_update!
    @support = Support.find(params[:id])
    return if @support.position_id != @position.id

    redirect_to issue_position_path(@position.issue, @position),
      alert: 'Already Support that Position'
  end

  def base_notification_params
    {supporter_profile: @profile, position: @position}
  end
end
