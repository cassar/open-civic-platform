require 'test_helper'

class PositionsControllerTest < ActionDispatch::IntegrationTest
  test 'get show' do
    get issue_position_url(issues(:one), positions(:one))
    assert_response :success
  end

  test 'get show with authenticated user' do
    sign_in users(:one)
    get issue_position_url(issues(:one), positions(:one))
    assert_response :success
  end
end
