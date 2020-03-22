require 'test_helper'

class NewPositionNotificationTest < ActiveSupport::TestCase
  setup do
    user = User.first
    group = Group.first
    issue = Issue.first
    position = Position.first
    @notification = NewPositionNotification.new(user, group, issue, position)
  end

  test 'notify!' do
    assert @notification.notify!
  end
end
