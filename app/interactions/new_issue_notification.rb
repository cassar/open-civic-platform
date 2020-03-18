class NewIssueNotification
  attr_reader :emails, :creator_profile, :group, :issue

  def initialize(creator_profile, group, issue)
    @creator_profile = creator_profile
    @group = group
    @issue = issue
    @emails = group.confirmed_profiles
      .where.not(id: creator_profile.id)
      .preload(:userable)
      .map(&:userable)
      .map(&:email)
  end

  def notify!
    emails.each do |email|
      IssueMailer.new_issue_email(email, creator_profile, group, issue)
        .deliver_later
    end
  end
end
