require 'test_helper'

class IssueTest < ActiveSupport::TestCase
  setup do
    @issue = Issue.first
    @position = Position.first
    @adoption = adoptions(:one)
    @support = Support.first
    @link = links(:stackoverflow)
  end

  test 'issue associations' do
    assert @issue.adoptions.include? @adoption
    assert @issue.supports.include? @support
    assert @issue.positions.include? @position
    assert @issue.links.include? @link
    @issue.destroy
    assert_raises(ActiveRecord::RecordNotFound) { @adoption.reload }
    assert_raises(ActiveRecord::RecordNotFound) { @link.reload }
  end

  test 'issue validations' do
    assert_not @issue.update name: nil
    assert_not @issue.update name: issues(:two).name
    assert_not @issue.update identifier: nil
    assert_not @issue.update identifier: issues(:two).identifier
  end

  test 'scopes' do
    assert Issue.published.include? @issue
    assert Issue.published.exclude? issues(:two)
  end
end
