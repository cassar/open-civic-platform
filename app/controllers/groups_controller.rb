class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    memberships = current_user.memberships
    @groups = Group.where(id: memberships.pluck(:group_id))
    @group_id_memberships = {}
    memberships.each { |m| @group_id_memberships[m.group_id] = m }
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      @group.create_new_member(current_user)
      redirect_to group_path(@group), notice: 'New Group Created'
    else
      flash[:alert] = @group.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_path(@group), notice: 'New Group Updated'
    else
      flash[:alert] = @group.errors.full_messages.to_sentence
      render :edit
    end
  end

  def show
    @group = Group.find(params[:id])
    @memberships = @group.memberships
    @id_users = {}
    User.find(@memberships.pluck(:user_id)).each { |u| @id_users[u.id] = u }
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end
