require 'test_helper'

class SupportNotificationsTest < ActiveSupport::TestCase
  setup do
    params = {
      supporter_profile: Profile.first,
      position: Position.first,
      old_position: Position.second
    }
    @notification = SupportNotifications.new(**params)
  end

  test 'notify_registered!' do
    assert @notification.notify_registered!
  end

  test 'notify_withdrawn!' do
    assert @notification.notify_withdrawn!
  end

  test 'notify_shifted!' do
    assert @notification.notify_shifted!
  end
end
