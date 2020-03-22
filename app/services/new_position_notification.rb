class NewPositionNotification
  attr_reader :emails, :creator_profile, :group, :issue, :position

  def initialize(creator_user, group, issue, position)
    @creator_profile = creator_user.profile
    @group = group
    @issue = issue
    @position = position
    @emails = group.confirmed_users
      .where.not(id: creator_user.id)
      .pluck(:email)
  end

  def notify!
    emails.each do |email|
      PositionsMailer.new_position_email(
        email: email,
        creator_profile: creator_profile,
        group: group,
        issue: issue,
        position: position
      ).deliver_later
    end
  end
end
