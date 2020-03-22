require 'test_helper'

class SupportMailerTest < ActionMailer::TestCase
  setup do
    @email = 'user@example.com'
    @profile = Profile.first
    @position = Position.first
  end

  test 'register_support_email' do
    assert SupportMailer.register_support_email(
      email: @email,
      supporter_profile: @profile,
      position: @position,
      support_count: 5
    ).deliver_now
  end

  test 'withdraw_support_email' do
    assert SupportMailer.withdraw_support_email(
      email: @email,
      supporter_profile: @profile,
      position: @position,
      support_count: 5
    ).deliver_now
  end

  test 'shift_support_email' do
    assert SupportMailer.shift_support_email(
      email: @email,
      supporter_profile: @profile,
      old_position: @position,
      new_position: @position,
      support_count: 5
    ).deliver_now
  end
end
