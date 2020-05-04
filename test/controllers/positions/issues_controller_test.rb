require 'test_helper'

class Positions::IssuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group = groups(:one)
    @position = positions(:one)
    sign_in users(:one)
  end

  test 'should get new' do
    get new_position_issue_url(@position)
    assert_response :success
  end

  test 'should post create' do
    assert_difference('Issue.count') do
      post position_issues_url(@position), params: { issue: { name: 'New Issue' } }
    end
    assert_redirected_to group_issue_path(@group, Issue.last)
  end

  test 'should post create fail' do
    assert_no_difference('Group.count') do
      post group_issues_url(@position), params: { issue: { name: nil } }
    end
    assert_response :success
  end
end
