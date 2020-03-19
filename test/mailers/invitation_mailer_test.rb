require 'test_helper'

class InvitationMailerTest < ActionMailer::TestCase
  setup do
    @group = Group.first
    @profile = Profile.second
  end

  test 'invitation_email' do
    assert InvitationMailer.invitation_email(
      User.second,
      @profile,
      Profile.first,
      @group
    ).deliver_now
  end

  test 'accepted_email' do
    assert InvitationMailer.accepted_email(
      User.first.email,
      @profile,
      @group
    ).deliver_now
  end
end
