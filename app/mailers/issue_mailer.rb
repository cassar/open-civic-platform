class IssueMailer < ApplicationMailer
  def new_issue_email(member_email, creator_profile, group, issue)
    @group = group
    @issue = issue

    mail to: member_email,
      subject: "New Issue #{issue.name} created by #{creator_profile.name}"
  end
end
