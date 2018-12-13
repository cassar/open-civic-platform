require 'test_helper'

class Issues::PositionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group = Group.first
    @issue = Issue.first
    @position = Position.first
    sign_in users(:one)
  end

  test 'should get new' do
    get new_issue_position_url(@issue)
    assert_response :success
  end

  test 'should post create' do
    assert_difference('Position.count') do
      post issue_positions_url(@issue), params: { position: { name: 'New Position' } }
    end
    assert_redirected_to group_issue_path(@group, @issue)
  end
end
