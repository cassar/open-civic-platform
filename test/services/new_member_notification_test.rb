require 'test_helper'

class NewMemberNotificationTest < ActiveSupport::TestCase
  setup do
    @group = Group.first
    @profile = Profile.first
    @notification = NewMemberNotification.new(@profile, @group)
  end

  test 'notify!' do
    assert @notification.notify!
  end
end
