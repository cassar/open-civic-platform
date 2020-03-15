# Preview all emails at http://localhost:3000/rails/mailers/issue_mailer
class IssueMailerPreview < ActionMailer::Preview
  def new_issue_email
    IssueMailer.new_issue_email('a@b.com', Profile.first, Group.first, Issue.second)
  end
end
