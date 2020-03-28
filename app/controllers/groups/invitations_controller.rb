class Groups::InvitationsController < GroupsController
  before_action :authenticate_user!, :authorize_user!

  def new
    @profiles = Profile
      .where(id: Membership.where(group: current_user.groups).pluck(:profile_id).uniq)
      .where.not(id: Membership.where(group: @group).pluck(:profile_id))
      .preload(:userable)
  end

  def create
    interaction = InviteNewMember.new invitation_params, @group, current_user
    if interaction.attempt!
      redirect_to new_group_invitation_path(@group),
        notice: interaction.notice
    else
      redirect_to new_group_invitation_path(@group),
        alert: interaction.errors.full_messages.to_sentence
    end
  end

  private

  def invitation_params
    params.require(:user).permit(:email, :profile_id)
  end
end
