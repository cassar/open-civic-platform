require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  setup do
    @group = Group.first
    @membership = Membership.first
    @profile = Profile.first
    @issue = Issue.first
    @confirmed_membership = @membership
    @confirmed_profile = @profile
    @invitation = Membership.second
  end

  test 'group associations' do
    assert @group.memberships.include? @membership
    assert @group.profiles.include? @profile
    assert @group.issues.include? @issue
    assert @group.confirmed_memberships.include? @confirmed_membership
    assert @group.confirmed_profiles.include? @confirmed_profile
    assert @group.invitations.include? @invitation
    @group.destroy
    assert_raises(ActiveRecord::RecordNotFound) { @membership.reload }
    assert_raises(ActiveRecord::RecordNotFound) { @issue.reload }
  end

  test 'group validations' do
    assert_not @group.update(name: nil)
  end
end
