require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
    @profile = profiles(:one)
  end

  test 'should get profile' do
    get profile_path
    assert_response :success
  end
end
