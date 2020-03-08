class InvitationMailer < ApplicationMailer
  def invitation_email(invitee_userable, invitee_profile, inviter_profile, group)
    @invitee_userable = invitee_userable
    @invitee_profile = invitee_profile
    @inviter_profile = inviter_profile
    @group = group

    mail to: @invitee_userable.email,
      subject: "Invitation from #{@inviter_profile.name}"
  end
end
