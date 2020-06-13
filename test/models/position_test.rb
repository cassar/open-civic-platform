require 'test_helper'

class PositionTest < ActiveSupport::TestCase
  setup do
    @position = Position.first
    @issue = Issue.first
    @user = User.first
    @support = Support.first
    @group = Group.first
    @profile = profiles(:one)
    @parent_position = positions(:two)
  end

  test 'position associations' do
    assert @position.issue == @issue
    assert @position.group == @group
    assert @position.supports.include? @support
    assert @position.supporting_profiles.include? @profile
    assert @parent_position.issues.include? @issue
    @position.destroy
    assert_raises(ActiveRecord::RecordNotFound) { @support.reload }
    @parent_position.destroy
    @issue.reload
    assert @issue.position.nil?
  end

  test 'position validations' do
    assert_not @position.update name: nil
  end

  test 'generate identifier callback' do
    position = Position.new(name: 'I agree')
    position.validate
    assert position.identifier == 'i_agree'
  end
end
