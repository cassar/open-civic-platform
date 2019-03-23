require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test 'coming soon as root' do
    get root_url
    assert_response :success
    assert_select '#logo'
    assert_select '#message'
  end
end
