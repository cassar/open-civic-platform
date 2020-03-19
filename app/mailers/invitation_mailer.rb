class InvitationMailer < ApplicationMailer
  def invitation_email(invitee_userable, invitee_profile, inviter_profile, group)
    @invitee_userable = invitee_userable
    @invitee_profile = invitee_profile
    @inviter_profile = inviter_profile
    @group = group

    mail to: @invitee_userable.email,
      subject: "Invitation from #{@inviter_profile.name}"
  end

  def accepted_email(notifyee_email, invitee_profile, group)
    @invitee_profile = invitee_profile
    @group = group

    mail to: notifyee_email,
      subject: "Invitation accepted by #{@invitee_profile.name}"
  end

  def declined_email(notifyee_email, invitee_profile, group)
    @invitee_profile = invitee_profile
    @group = group

    mail to: notifyee_email,
      subject: "Invitation declined by #{@invitee_profile.name}"
  end
end
