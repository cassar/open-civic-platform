class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!, only: %i[edit update]
  before_action :authorize_user_show!, only: :show

  def index
    @profile = current_user.profile
    @memberships = current_user.confirmed_memberships.preload(:group)
    @invitations = current_user.invitations.preload(:group)
  end

  def show
    @memberships = group.confirmed_memberships.preload(:profile)
    @invitations = group.invitations.preload profile: :userable
    @issues = group.issues
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
    if group.update(group_params)
      redirect_to group_path(group), notice: 'New Group Updated'
    else
      flash[:alert] = group.errors.full_messages.to_sentence
      render :edit
    end
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

  def authorize_user!
    return if group.confirmed_profiles.include? current_user.profile

    redirect_failed_authorization
  end

  def authorize_user_show!
    return if (
      group.confirmed_profiles | group.invited_profiles
    ).include? current_user.profile

    redirect_failed_authorization
  end

  def redirect_failed_authorization
    redirect_to root_path, alert: 'Not able to interact with this group.'
  end

  def group
    @group ||= Group.find(params[:group_id] || params[:id])
  end
end
