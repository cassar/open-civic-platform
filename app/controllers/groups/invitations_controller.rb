class Groups::InvitationsController < GroupsController
  before_action :authenticate_user!
  before_action :authorize_user!

  def new
    if params[:profile_id].present?
      @profile = Profile.find(params[:profile_id])
      @membership = @profile.memberships.find_by(group: @group)
    elsif params[:term].present?
      search_for_profiles
    end
  end

  def create
    invitation = @group.invitations.create(membership_params)
    if invitation.persisted?
      flash[:notice] = 'New member Invited'
      redirect_to group_path(@group)
    else
      flash[:alert] = invitation.errors.full_messages.to_sentence
      redirect_to new_group_invitation_path(@group)
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:profile_id)
  end

  def search_for_profiles
    @profiles = []
    Profile.all.preload(:userable).each do |profile|
      next unless "#{profile.name} #{profile.userable.email}".downcase.include? params[:term].downcase

      @profiles << profile
    end
  end
end
