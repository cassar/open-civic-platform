require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group = Group.first
    sign_in users(:one)
  end

  test 'should get show' do
    get group_url @group
    assert_response :success
  end

  test 'should get new' do
    get new_group_url
    assert_response :success
  end

  test 'should post create' do
    assert_difference('Group.count') do
      post groups_url params: { group: { name: 'Fun Group' } }
    end
    assert_redirected_to group_path(Group.last)
  end

  test 'should post create fail' do
    assert_no_difference('Group.count') do
      post groups_url params: { group: { name: nil } }
    end
    assert_response :success
  end

  test 'should get edit' do
    get edit_group_url @group
    assert_response :success
  end

  test 'should patch update' do
    patch group_url(@group), params: { group: { name: 'updated' } }
    assert_redirected_to group_path @group
    @group.reload
    assert @group.name == 'updated'
  end
end
