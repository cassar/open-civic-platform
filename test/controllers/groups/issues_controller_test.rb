require 'test_helper'

class Groups::IssuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group = Group.first
    @issue = Issue.first
    sign_in users(:one)
  end

  test 'should get show' do
    get group_issue_url @group, @issue
    assert_response :success
  end

  test 'should get new' do
    get new_group_issue_url(@group)
    assert_response :success
  end

  test 'should post create' do
    assert_difference('Issue.count') do
      post group_issues_url(@group), params: { issue: { name: 'New Issue' } }
    end
    assert_redirected_to group_issue_path(@group, Issue.last)
  end

  test 'should post create fail' do
    assert_no_difference('Group.count') do
      post group_issues_url(@group), params: { issue: { name: nil } }
    end
    assert_response :success
  end
end
