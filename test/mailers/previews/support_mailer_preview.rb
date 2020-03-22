# Preview all emails at http://localhost:3000/rails/mailers/support_mailer
class SupportMailerPreview < ActionMailer::Preview
  def register_support_email
    SupportMailer.register_support_email(
      email: 'a@b.com',
      supporter_profile: Profile.first,
      position: Position.first,
      support_count: 5
    )
  end

  def withdraw_support_email
    SupportMailer.withdraw_support_email(
      email: 'a@b.com',
      supporter_profile: Profile.first,
      position: Position.first,
      support_count: 5
    )
  end

  def shift_support_email
    SupportMailer.shift_support_email(
      email: 'a@b.com',
      supporter_profile: Profile.first,
      old_position: Position.first,
      new_position: Position.second,
      support_count: 5
    )
  end
end
