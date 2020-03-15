require 'test_helper'

class InvitationMailerTest < ActionMailer::TestCase
  test 'invitation_email' do
    assert InvitationMailer.invitation_email(
      User.second,
      Profile.second,
      Profile.first,
      Group.first
    ).deliver_now
  end
end
