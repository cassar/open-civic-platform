require 'test_helper'

class PositionTest < ActiveSupport::TestCase
  setup do
    @position = Position.first
    @issue = Issue.first
  end

  test 'position associations' do
    assert @position.issue == @issue
  end

  test 'position validations' do
    assert_not @position.update name: nil
  end
end
