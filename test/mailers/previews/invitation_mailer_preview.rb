# Preview all emails at http://localhost:3000/rails/mailers/invitation_mailer
class InvitationMailerPreview < ActionMailer::Preview
  def invitation_email
    InvitationMailer.invitation_email User.second, Profile.second, Profile.first, Group.first
  end

  def accepted_email
    InvitationMailer.accepted_email User.first.email, Profile.second, Group.first
  end

  def declined_email
    InvitationMailer.declined_email User.first.email, Profile.second, Group.first
  end
end
