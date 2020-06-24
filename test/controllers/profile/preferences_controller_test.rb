require 'test_helper'

class Profile::PreferencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @support = supports(:three)
  end

  test 'patch update' do
    sign_in users(:three)
    assert @support.preference == 3
    patch profile_preference_path(@support), params: { preference: 1 }
    assert @support.reload.preference == 1
    assert_redirected_to profile_issue_path(@support.issue)
  end

  test 'authorize_user!' do
    sign_in users(:one)
    patch profile_preference_path(@support), params: { preference: 1 }
    assert_redirected_to profile_path
  end
end
