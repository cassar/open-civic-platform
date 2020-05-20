require 'test_helper'

class SupportTest < ActiveSupport::TestCase
  setup do
    @support = Support.first
    @membership = Membership.first
    @position = Position.first
    @issue = Issue.first
    @profile = Profile.first
    @user = User.first
  end

  test 'support associations' do
    assert @support.position == @position
    assert @support.membership == @membership
    assert @support.issue == @issue
    assert @support.profile == @profile
    assert @support.user == @user
  end

  test 'support scopes' do
    assert Support.subscribed.include? @support
    assert Support.subscribed.exclude? supports(:two)
  end

  test 'only_one_support_per_issue' do
    assert_not @membership.supports.create(position_id: 2).persisted?
  end
end
