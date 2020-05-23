require 'test_helper'

class SupportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @issue = issues(:one)
    @support = supports(:one)
    sign_in users(:one)
  end

  test 'should patch update' do
    old_value = @support.subscribed
    patch toggle_subscription_support_url(@support)
    assert_redirected_to group_issue_url(@issue.group_id, @issue)
    assert old_value != @support.reload.subscribed
  end
end
