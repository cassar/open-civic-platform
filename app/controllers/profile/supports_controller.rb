class Profile::SupportsController < ApplicationController
  before_action :authenticate_user!, :records_for_create

  def create
    if support.save
      redirect_to issue_position_path(@issue, @position),
        notice: 'Successfully Supported Position'
    else
      redirect_to issue_path(@issue),
        alert: support.errors.full_messages.to_sentence
    end
  end

  def destroy
    @support = Support.find params[:id]
    @support.destroy
    redirect_to issue_position_path(@support.issue, @support.position), notice: 'Support Removed'
  end

  private

  def position_params
    params.require(:position).permit(:id)
  end

  def records_for_create
    @issue = Issue.find_by_id params[:issue_id]
    @position = Position.find_by_id params[:position_id]
  end

  def support
    @support ||= Support.new(
      position: @position,
      adoption: adoption,
      preference: (adoption.supports.count + 1)
    )
  end

  def adoption
    @adoption ||= Adoption.find_or_create_by(
      issue: @issue,
      profile: current_user.profile
    )
  end
end
