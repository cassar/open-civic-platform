require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test 'landing page as root' do
    get root_url
    assert_response :success
    assert_select 'logo'
    assert_select '.options'
  end

  test 'landing page redirected if authenticated' do
    sign_in users(:one)
    get root_url
    assert_redirected_to home_url
  end
end
