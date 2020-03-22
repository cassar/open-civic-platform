class SupportMailer < ApplicationMailer
  def register_support_email(email:, supporter_profile:, position:, support_count:)
    @supporter_profile = supporter_profile
    @position = position
    @support_count = support_count

    mail to: email,
      subject: "Position Support registered for #{supporter_profile.name}"
  end

  def withdraw_support_email(email:, supporter_profile:, position:, support_count:)
    @supporter_profile = supporter_profile
    @position = position
    @support_count = support_count

    mail to: email,
      subject: "Position Support withdrawn by #{supporter_profile.name}"
  end

  def shift_support_email(email:, supporter_profile:, old_position:, new_position:, support_count:)
    @supporter_profile = supporter_profile
    @old_position = old_position
    @new_position = new_position
    @support_count = support_count

    mail to: email,
      subject: "Position Support shifted by #{supporter_profile.name}"
  end
end
