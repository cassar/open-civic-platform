require 'test_helper'

class NewMemberNotificationTest < ActiveSupport::TestCase
  setup do
    @group = Group.first
    @profile = Profile.first
    @notification = NewMemberNotification.new(@profile, @group)
  end

  test 'notify_accepted!' do
    assert @notification.notify_accepted!
  end

  test 'notify_declined!' do
    assert @notification.notify_declined!
  end
end
