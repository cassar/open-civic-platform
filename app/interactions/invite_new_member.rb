class InviteNewMember
  attr_reader :invitation, :email, :group, :inviter_user, :profile_id

  def initialize(membership_params, group, inviter_user)
    @email = membership_params[:email]
    @profile = Profile.find_by_id membership_params[:profile_id]
    @group = group
    @inviter_user = inviter_user
  end

  def attempt!
    profile

    return false unless userable.persisted?

    @invitation = group.invitations.create profile: profile
    return false unless invitation.persisted?

    notify_member

    true
  end

  def errors
    if userable.errors.present?
      userable.errors
    elsif invitation.errors.present?
      invitation.errors
    else
      ''
    end
  end

  def notice
    "#{profile.name || email} Invited"
  end

  private

  def notify_member
    InvitationMailer.invitation_email(userable, profile, inviter_user.profile, group)
      .deliver_now
  end

  def userable
    @userable ||= @profile&.userable
    @userable ||= User.find_by_email email
    @userable ||= Placeholder.find_or_create_by email: email
  end

  def profile
    @profile ||= userable.profile
  end
end
