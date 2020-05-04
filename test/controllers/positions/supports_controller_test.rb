require 'test_helper'

class Positions::SupportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @position = Position.first
    @new_position = Position.second
    @support = Support.first
    @group = Group.first
    @issue = Issue.first
    sign_in users(:one)
  end

  test 'should post create' do
    @support.destroy
    assert_difference('Support.count') do
      post position_supports_url(@position)
    end
    assert_redirected_to issue_position_url(@issue, @position)
  end

  test 'should patch update' do
    patch position_support_url(@new_position, @support)
    assert_redirected_to issue_position_url(@issue, @new_position)
    assert_equal 'Support Shifted', flash[:notice]
  end

  test 'should redirect invalid update' do
    patch position_support_url(@position, @support)
    assert_redirected_to issue_position_url(@issue, @position)
    assert_equal 'Already Support that Position', flash[:alert]
  end

  test 'should delete destroy' do
    assert_difference('Support.count', -1) do
      delete position_support_url(@position, @support)
    end
    assert_redirected_to issue_position_url(@issue, @position)
  end
end
