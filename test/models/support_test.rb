require 'test_helper'

class SupportTest < ActiveSupport::TestCase
  setup do
    @support = Support.first
    @position = Position.first
    @issue = Issue.first
    @membership = Membership.first
  end

  test 'support associations' do
    assert @support.position == @position
    assert @support.membership == @membership
    assert @support.issue == @issue
  end

  test 'only_one_support_per_issue' do
    assert_not @membership.supports.create(position_id: 2).persisted?
  end
end
