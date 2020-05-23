require 'test_helper'

class IssueTest < ActiveSupport::TestCase
  setup do
    @issue = Issue.first
    @group = Group.first
    @position = Position.first
    @parent_position = positions(:two)
    @support = Support.first
    @user = User.first
  end

  test 'issue associations' do
    assert @issue.group == @group
    assert @issue.position == @parent_position
    assert @issue.supports.include? @support
    assert @issue.subscribed_supports.include? @support
    assert @issue.subscribed_supports.exclude? supports(:two)
    assert @issue.subscribed_users.include? @user
    assert @issue.subscribed_users.exclude? users(:three)
    assert @issue.positions.include? @position
    @issue.destroy
    assert_raises(ActiveRecord::RecordNotFound) { @position.reload }
  end

  test 'issue validations' do
    assert_not @issue.update name: nil
  end
end
