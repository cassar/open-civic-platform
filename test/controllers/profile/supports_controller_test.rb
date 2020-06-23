require 'test_helper'

class Profile::SupportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @issue = issues(:one)
    @position = positions(:two)
    sign_in users(:one)
  end

  test 'should post create existing adoption' do
    assert_no_difference('Adoption.count') do
      assert_creates_support
    end
  end

  test 'should post create no existing adoption' do
    @issue = issues(:two)
    assert_difference('Adoption.count') do
      assert_creates_support
    end
  end

  def assert_creates_support
    assert_difference('Support.count') do
      assert_no_difference('Position.count') do
        post profile_issue_position_supports_path(@issue, @position)
      end
    end
    assert_redirected_to profile_issue_position_path(@issue, @position)
  end

  test 'should post create fail' do
    assert_no_difference('Adoption.count') do
      assert_no_difference('Support.count') do
        assert_no_difference('Position.count') do
          post profile_issue_position_supports_path(@issue, positions(:one))
        end
      end
    end
    assert_redirected_to issue_path(@issue)
  end
end
