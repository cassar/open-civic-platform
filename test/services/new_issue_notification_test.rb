require 'test_helper'

class NewIssueNotificationTest < ActiveSupport::TestCase
  setup do
    @group = Group.first
    @profile = Profile.first
    @issue = Issue.first
    @notification = NewIssueNotification.new(@profile, @group, @issue)
  end

  test 'notify!' do
    assert @notification.notify!
  end
end
