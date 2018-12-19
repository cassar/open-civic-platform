require 'test_helper'

class IssueTest < ActiveSupport::TestCase
  setup do
    @issue = Issue.first
    @group = Group.first
    @position = Position.first
    @support = Support.first
  end

  test 'issue associations' do
    assert @issue.group == @group
    assert @issue.positions.include? @position
    assert @issue.supports.include? @support
    @issue.destroy
    assert_raises(ActiveRecord::RecordNotFound) { @position.reload }
  end

  test 'issue validations' do
    assert_not @issue.update name: nil
  end
end
