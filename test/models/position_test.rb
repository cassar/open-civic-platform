require 'test_helper'

class PositionTest < ActiveSupport::TestCase
  setup do
    @position = Position.first
    @issue = Issue.first
    @user = User.first
    @support = Support.first
    @group = Group.first
    @profile = profiles(:one)
  end

  test 'position associations' do
    assert @position.issue == @issue
    assert @position.group == @group
    assert @position.confirmed_users.include? @user
    assert @position.supports.include? @support
    assert @position.supporting_profiles.include? @profile
    @position.destroy
    assert_raises(ActiveRecord::RecordNotFound) { @support.reload }
  end

  test 'position validations' do
    assert_not @position.update name: nil
  end
end
