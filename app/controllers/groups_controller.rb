class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!, only: %i[edit update show]

  def index
    @memberships = current_user.confirmed_memberships.preload(:group)
    @invitations = current_user.invitations.preload(:group)
  end

  def show
    @memberships = @group.confirmed_memberships.preload(:profile)
    @invitations = @group.invitations.preload(:profile)
  end

  def new
    @group = Group.new
  end

  def create
    @group = current_user.profile.groups.create group_params
    if @group.persisted?
      redirect_to group_path(@group), notice: 'New Group Created'
    else
      flash[:alert] = @group.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit; end

  def update
    if @group.update(group_params)
      redirect_to group_path(@group), notice: 'New Group Updated'
    else
      flash[:alert] = @group.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

  def authorize_user!
    @group = retrieve_group
    return if @group.confirmed_profiles.include? current_user.profile

    redirect_to root_path, alert: 'Not able to interact with this group.'
  end

  def retrieve_group
    if params[:id].present?
      Group.find(params[:id])
    else
      Group.find(params[:group_id])
    end
  end
end
