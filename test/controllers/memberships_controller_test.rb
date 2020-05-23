require 'test_helper'

class MembershipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    sign_in users(:one)
    @membership = memberships(:one)
  end

  test 'should update subscribed' do
    old_value = @membership.subscribed
    patch toggle_subscription_membership_url(@membership)
    assert_redirected_to group_path(groups(:one))
    assert_not old_value == @membership.reload.subscribed
  end
end
