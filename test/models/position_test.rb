require 'test_helper'

class PositionTest < ActiveSupport::TestCase
  setup do
    @position = Position.first
    @issue = Issue.first
    @support = Support.first
  end

  test 'position associations' do
    assert @position.issue == @issue
    assert @position.supports.include? @support
    @position.destroy
    assert_raises(ActiveRecord::RecordNotFound) { @support.reload }
  end

  test 'position validations' do
    assert_not @position.update name: nil
  end
end
