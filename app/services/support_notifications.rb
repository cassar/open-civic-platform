class SupportNotifications
  attr_reader :emails, :supporter_profile, :position, :support_count, :old_position

  def initialize(supporter_profile:, position:, old_position: nil)
    @supporter_profile = supporter_profile
    @position = position
    @old_position = old_position
    @support_count = position.supports.count
    @emails = position.confirmed_users
      .where.not(id: supporter_profile.userable_id)
      .pluck(:email)
  end

  def notify_registered!
    emails.each do |email|
      SupportMailer.register_support_email(
        email: email,
        supporter_profile: supporter_profile,
        position: position,
        support_count: support_count
      ).deliver_later
    end
  end

  def notify_withdrawn!
    emails.each do |email|
      SupportMailer.withdraw_support_email(
        email: email,
        supporter_profile: supporter_profile,
        position: position,
        support_count: support_count
      ).deliver_later
    end
  end

  def notify_shifted!
    emails.each do |email|
      SupportMailer.shift_support_email(
        email: email,
        supporter_profile: supporter_profile,
        position: position,
        support_count: support_count,
        old_position: old_position
      ).deliver_later
    end
  end
end
