require 'test_helper'

class SubmissionTest < ActiveSupport::TestCase
  setup do
    @submission = submissions(:one)
    @group = groups(:one)
    @issue = issues(:one)
  end

  test 'associations' do
    assert @submission.group == @group
    assert @submission.issue == @issue
  end
end
