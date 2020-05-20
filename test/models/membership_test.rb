require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  setup do
    @membership = Membership.first
    @profile = Profile.first
    @group = Group.first
    @confirmed = @membership
    @invited = Membership.second
    @support = Support.first
    @issue = Issue.first
    @support = Support.first
  end

  test 'membership associations' do
    assert @membership.profile == @profile
    assert @membership.group == @group
    assert @membership.supports.include? @support
    assert @membership.issues_engaged.include? @issue
    assert @membership.supports.include? @support
    @membership.destroy
    assert_raises(ActiveRecord::RecordNotFound) { @support.reload }
  end

  test 'membership scopes' do
    assert Membership.confirmed.include? @confirmed
    assert Membership.invited.include? @invited
    assert Membership.subscribed.include? @membership
    assert Membership.subscribed.exclude? @invited
  end

  test 'membership validations' do
    assert_not @membership.update(status: 'Test')
    assert @membership.update(status: %w[Invitee Member].sample)
    assert_not @membership.update(group_id: 2)
  end
end
