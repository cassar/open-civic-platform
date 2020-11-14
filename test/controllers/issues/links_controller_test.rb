require 'test_helper'

class Issues::LinksControllerTest < ActionDispatch::IntegrationTest
  test 'should redirect unauthenticated' do
    get new_issue_link_path issues(:one)
    assert_redirected_to new_user_session_path
  end

  test 'should get new' do
    sign_in users(:one)
    get new_issue_link_path issues(:one)
    assert_response :success
  end

  test 'should post create success' do
    sign_in users(:one)
    assert_difference 'Link.count', 1 do
      post issue_links_path(issues(:one), params: {
        link: { url: 'https://github.com/' }
      })
    end
    assert_redirected_to profile_issue_path issues(:one)
  end

  test 'should post create fail' do
    sign_in users(:one)
    assert_no_difference 'Link.count' do
      post issue_links_path(issues(:one), params: {
        link: { url: 'xxx' }
      })
    end
    assert_response :success
  end

  test 'should delete destroy' do
    sign_in users(:one)
    assert_difference 'Link.count', -1 do
      delete issue_link_path(issues(:one), links(:stackoverflow))
    end
    assert_redirected_to profile_issue_path issues(:one)
  end
end
