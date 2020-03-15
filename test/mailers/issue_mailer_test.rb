require 'test_helper'

class IssueMailerTest < ActionMailer::TestCase
  setup do
    @profile = Profile.first
    @group = Group.first
    @issue = Issue.first
    @email = 'user@example.com'
  end

  test 'new_issue_email' do
    assert IssueMailer.new_issue_email(@email, @profile, @group, @issue)
      .deliver_later
  end
end
