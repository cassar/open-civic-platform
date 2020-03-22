require 'test_helper'

class InvitationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group = Group.first
    sign_in users(:one)
    @invitation = Membership.second
  end

  test 'should patch update' do
    assert @invitation.invited?
    patch invitation_url(@invitation)
    assert_redirected_to group_path(@group)
    @invitation.reload
    assert @invitation.confirmed?
  end

  test 'should delete destroy atleast' do
    assert @invitation.invited?
    assert @group.memberships.confirmed.present?
    assert_difference 'Membership.count', -1 do
      delete invitation_url(@invitation)
    end
    assert_redirected_to groups_path
  end
end
