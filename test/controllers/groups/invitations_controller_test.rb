require 'test_helper'

class Groups::InvitationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group = Group.first
    sign_in users(:one)
  end

  test 'should get new' do
    get new_group_invitation_url(@group)
    assert_response :success
  end

  test 'should post create' do
    assert_difference 'Membership.count', 1 do
      post group_invitations_url(@group), params: { user: {
        email: 'name@example.com' }
      }
    end
    assert_redirected_to new_group_invitation_url(@group)
  end

  test 'should post create fail' do
    assert_no_difference 'Membership.count' do
      post group_invitations_url(@group), params: { user: {
        email: '@example.com' }
      }
    end
    assert_redirected_to new_group_invitation_url(@group)
  end
end
