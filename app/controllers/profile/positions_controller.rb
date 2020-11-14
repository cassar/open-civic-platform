class Profile::PositionsController < ApplicationController
  before_action :authenticate_user!

  after_action :support_position, only: :create

  def show
    @issue = Issue.find_by_id params[:issue_id]
    @position = Position.find_by_id params[:id]
    @links = @position.links
  end

  def new
    @issue = Issue.find_by_id params[:issue_id]
    @position = Position.new
  end

  def edit
    @issue = Issue.find_by_id params[:issue_id]
    @position = Position.find_by_id params[:id]
  end

  def update
    @issue = Issue.find_by_id params[:issue_id]
    @position = Position.find_by_id params[:id]
    if @position.update(position_params)
      redirect_to profile_issue_position_path(@issue, @position),
        notice: 'Successfully Updated Position'
    else
      flash[:alert] = @position.errors.full_messages.to_sentence
      render :edit
    end
  end

  def create
    @issue = Issue.find_by_id(params[:issue_id])
    @position = Position.new(position_params)
    if @position.save
      redirect_to profile_issue_path(@issue),
        notice: 'Successfully Created Position'
    else
      flash[:alert] = @position.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def position_params
    params.require(:position).permit(:name, :outline)
  end

  def support_position
    return unless flash[:notice].present?

    adoption = Adoption.find_or_create_by(
      profile: current_user.profile,
      issue: @issue
    )
    Support.create(
      position: @position,
      adoption: adoption,
      preference: (adoption.supports.count + 1)
    )
  end
end
