require 'test_helper'

class Profile::IssuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @issue = issues(:one)
    sign_in users(:one)
  end

  test 'get show' do
    get profile_issue_path(issues(:one))
    assert_response :success
  end

  test 'get new' do
    get new_profile_issue_path
    assert_response :success
  end

  test 'should post create new issue' do
    assert_difference('Adoption.count') do
      assert_difference('Issue.count') do
        post profile_issues_path, params: { issue: { name: 'New Issue' } }
      end
    end
    assert_redirected_to issue_path(Issue.last)
  end

  test 'should post create new adoption' do
    assert_difference('Adoption.count') do
      assert_no_difference('Issue.count') do
        post profile_issues_path, params: { issue: { name: 'MyString3' } }
      end
    end
    assert_redirected_to issue_path(issues(:three))
  end

  test 'should post create fail issue name' do
    assert_no_difference('Adoption.count') do
      assert_no_difference('Issue.count') do
        post profile_issues_path, params: { issue: { name: nil } }
      end
    end
    assert_response :success
  end

  test 'should post create fail existing adoption' do
    assert_no_difference('Adoption.count') do
      assert_no_difference('Issue.count') do
        post profile_issues_path, params: { issue: { name: 'MyString1' } }
      end
    end
    assert_response :success
  end

  test 'should get edit' do
    get edit_profile_issue_path(@issue)
    assert_response :success
  end

  test 'should patch update success' do
    patch profile_issue_path(@issue, params: { issue: { name: 'MyString2' }})
    @issue.reload
    @issue.name == 'MyString2'
  end

  test 'should patch update fail' do
    patch profile_issue_path(@issue, params: { issue: { name: nil }})
    old_name = @issue.name
    @issue.reload
    @issue.name == old_name
  end
end
