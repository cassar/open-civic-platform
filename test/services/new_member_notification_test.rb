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
end
