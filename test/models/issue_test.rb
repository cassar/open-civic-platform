require 'test_helper'

class IssueTest < ActiveSupport::TestCase
  setup do
    @issue = Issue.first
    @position = Position.first
    @adoption = adoptions(:one)
    @support = Support.first
  end

  test 'issue associations' do
    assert @issue.adoptions.include? @adoption
    assert @issue.supports.include? @support
    assert @issue.positions.include? @position
    @issue.destroy
    assert_raises(ActiveRecord::RecordNotFound) { @adoption.reload }
  end

  test 'issue validations' do
    assert_not @issue.update name: nil
    assert_not @issue.update name: issues(:two).name
    assert_not @issue.update identifier: nil
    assert_not @issue.update identifier: issues(:two).identifier
  end

  test 'generate identifier callback' do
    issue = Issue.new(name: 'Hello you')
    issue.validate
    assert issue.identifier == 'hello_you'
  end
end
