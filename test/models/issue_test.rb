require 'test_helper'

class IssueTest < ActiveSupport::TestCase
  setup do
    @issue = Issue.first
    @group = Group.first
  end

  test 'issue associations' do
    assert @issue.group == @group
  end

  test 'issue validations' do
    assert_not @issue.update name: nil
  end
end
