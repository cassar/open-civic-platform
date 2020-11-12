require 'test_helper'

class IssuesControllerTest < ActionDispatch::IntegrationTest
  test 'get root' do
    get root_url
    assert_response :success
    assert_select 'logo'
  end

  test 'get show' do
    get issue_url(issues(:one))
    assert_response :success
  end

  test 'check_published!' do
    get issue_path(issues(:two))
    assert_redirected_to issues_path
  end
end
