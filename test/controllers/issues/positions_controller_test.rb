require 'test_helper'

class Issues::PositionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group = Group.first
    @issue = Issue.first
    @position = Position.first
    @membership = memberships(:one)
    sign_in users(:one)
  end

  test 'should get new' do
    get new_issue_position_url(@issue)
    assert_response :success
  end

  test 'should get show' do
    get issue_position_url(@issue, @position)
    assert_response :success
  end

  test 'should post create' do
    Support.destroy_all
    assert_difference('Position.count') do
      post issue_positions_url(@issue), params: { position: { name: 'New Position' } }
    end
    assert_redirected_to group_issue_path(@group, @issue)
    assert Support.find_by(position: Position.last, membership: @membership)
  end
end
