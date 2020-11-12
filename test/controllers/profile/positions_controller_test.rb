require 'test_helper'

class Profile::PositionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @issue = issues(:one)
    @position = positions(:one)
    sign_in users(:one)
  end

  test 'should get show' do
    get profile_issue_position_url(@issue, @position)
    assert_response :success
  end

  test 'should get new' do
    get new_profile_issue_position_path(@issue)
    assert_response :success
  end

  test 'should post create existing adoption' do
    assert_no_difference('Adoption.count') do
      assert_creates_position
    end
  end

  test 'should post create no existing adoption' do
    @issue = issues(:two)
    assert_difference('Adoption.count') do
      assert_creates_position
    end
  end

  def assert_creates_position
    assert_difference('Support.count') do
      assert_difference('Position.count') do
        post profile_issue_positions_path(@issue), params: {
          position: { name: 'New Position' }
        }
      end
    end
    assert_redirected_to profile_issue_path(@issue)
  end

  test 'should post create fail' do
    assert_no_difference('Adoption.count') do
      assert_no_difference('Support.count') do
        assert_no_difference('Position.count') do
          post profile_issue_positions_path(@issue), params: {
            position: { name: nil }
          }
        end
      end
    end
    assert_response :success
  end

  test 'should get edit' do
    get edit_profile_issue_position_url(@issue, @position)
    assert_response :success
  end

  test 'should patch update success' do
    patch profile_issue_position_path(@issue, @position), params: {
      position: { outline: 'updated'}
    }
    assert_redirected_to profile_issue_position_path(@issue, @position)
    @position.reload
    assert @position.outline == 'updated'
  end

  test 'should patch update fail' do
    patch profile_issue_position_path(@issue, @position), params: {
      position: { name: nil }
    }
    assert_response :success
    @position.reload
    assert @position.name == 'MyString1'
  end
end
