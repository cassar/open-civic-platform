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
end
