require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  setup do
    @profile_user = Profile.first
    @profile_placeholder = Profile.second
    @user = User.first
    @placeholder = Placeholder.first
    @profile = @profile_user
    @membership = Membership.first
    @confirmed_membership = @membership
    @invitation = Membership.third
    @group = Group.first
    @support = supports(:one)
    @issue = issues(:one)
  end

  test 'associations' do
    assert @profile_user.userable == @user
    assert @profile_placeholder.userable == @placeholder
    assert @profile.memberships.include? @membership
    assert @profile.confirmed_memberships.include? @confirmed_membership
    assert @profile.invitations.include? @invitation
    assert @profile.groups.include? @group
    assert @profile.supports.include? @support
    assert @profile.issues_supporting.include? @issue
    @profile.destroy
    assert_raises(ActiveRecord::RecordNotFound) { @membership.reload }
    assert_raises(ActiveRecord::RecordNotFound) { @support.reload }
  end
end
