class NewMemberNotification
  attr_reader :emails, :invitee_profile, :group

  def initialize(invitee_profile, group)
    @invitee_profile = invitee_profile
    @group = group
    @emails = group.confirmed_subscribed_users
      .where.not(id: invitee_profile.userable_id)
      .pluck(:email)
  end

  def notify_accepted!
    emails.each do |email|
      InvitationMailer.accepted_email(email, invitee_profile, group)
        .deliver_later
    end
  end

  def notify_declined!
    emails.each do |email|
      InvitationMailer.declined_email(email, invitee_profile, group)
        .deliver_later
    end
  end
end
