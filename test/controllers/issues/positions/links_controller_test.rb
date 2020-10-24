require 'test_helper'

class Issues::Positions::LinksControllerTest < ActionDispatch::IntegrationTest
  test 'should redirect unauthenticated' do
    get new_issue_position_link_path issues(:one), positions(:one)
    assert_redirected_to new_user_session_path
  end

  test 'should get new' do
    sign_in users(:one)
    get new_issue_position_link_path issues(:one), positions(:one)
    assert_response :success
  end

  test 'should post create success' do
    sign_in users(:one)
    assert_difference 'Link.count', 1 do
      post issue_position_links_path(issues(:one), positions(:one), params: {
        link: { url: 'https://github.com/' }
      })
    end
    assert_redirected_to issue_position_path issues(:one), positions(:one)
  end

  test 'should post create fail' do
    sign_in users(:one)
    assert_no_difference 'Link.count' do
      post issue_position_links_path(issues(:one), positions(:one), params: {
        link: { url: 'xxx' }
      })
    end
    assert_response :success
  end

  test 'should delete destroy' do
    sign_in users(:one)
    assert_difference 'Link.count', -1 do
      delete issue_position_link_path(issues(:one), positions(:one), links(:open_civic))
    end
    assert_redirected_to issue_position_path issues(:one), positions(:one)
  end
end
