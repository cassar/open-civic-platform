require 'test_helper'

class Profile::IssuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
  end

  test 'get show' do
    get profile_issue_path(issues(:one))
    assert_response :success
  end
end
