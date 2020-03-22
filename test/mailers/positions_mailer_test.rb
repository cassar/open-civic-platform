require 'test_helper'

class PositionsMailerTest < ActionMailer::TestCase
  setup do
    @email = 'user@example.com'
    @profile = Profile.first
    @group = Group.first
    @issue = Issue.first
    @position = Position.first
  end

  test 'new_position_email' do
    assert PositionsMailer.new_position_email(
      email: @email,
      creator_profile: @profile,
      group: @group,
      issue: @issue,
      position: @position
    ).deliver_now
  end
end
