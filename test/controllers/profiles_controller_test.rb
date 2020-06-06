require 'test_helper'

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile = Profile.first
    sign_in users(:one)
  end

  test 'should get home (show)' do
    get home_url
    assert_response :success
  end

  test 'should get edit' do
    @profile.update name: nil
    get root_url
    assert_redirected_to complete_profile_url
  end

  test 'should patch update' do
    patch profile_url(@profile), params: { profile: { name: 'updated' } }
    assert_redirected_to root_path
    @profile.reload
    assert @profile.name == 'updated'
  end
end
