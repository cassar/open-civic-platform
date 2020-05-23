require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  setup do
    @group = Group.first
    @membership = Membership.first
    @profile = Profile.first
    @user = User.first
    @issue = Issue.first
    @confirmed_membership = @membership
    @confirmed_profile = @profile
    @invitation = Membership.second
    @invited_profile = @invitation.profile
  end

  test 'group associations' do
    assert @group.memberships.include? @membership
    assert @group.profiles.include? @profile
    assert @group.issues.include? @issue
    assert @group.confirmed_memberships.include? @confirmed_membership
    assert @group.confirmed_subscribed_memberships.include? @confirmed_membership
    assert @group.confirmed_subscribed_memberships.exclude? memberships(:four)
    assert @group.confirmed_profiles.include? @confirmed_profile
    assert @group.confirmed_subscribed_profiles.include? @confirmed_profile
    assert @group.confirmed_subscribed_profiles.exclude? profiles(:four)
    assert @group.confirmed_users.include? @user
    assert @group.confirmed_subscribed_users.include? @user
    assert @group.confirmed_subscribed_users.exclude? users(:three)
    assert @group.invitations.include? @invitation
    assert @group.invited_profiles.include? @invited_profile
    @group.destroy
    assert_raises(ActiveRecord::RecordNotFound) { @membership.reload }
    assert_raises(ActiveRecord::RecordNotFound) { @issue.reload }
  end

  test 'group validations' do
    assert_not @group.update(name: nil)
  end
end
