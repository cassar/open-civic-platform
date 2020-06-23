require 'test_helper'

class SupportTest < ActiveSupport::TestCase
  setup do
    @support = Support.first
    @adoption = adoptions(:one)
    @position = Position.first
    @issue = Issue.first
    @profile = Profile.first
    @user = User.first
  end

  test 'associations' do
    assert @support.adoption == @adoption
    assert @support.position == @position
    assert @support.issue == @issue
    assert @support.profile == @profile
    assert @support.user == @user
  end

  test 'scopes' do
    assert Support.subscribed.include? @support
    assert Support.subscribed.exclude? supports(:two)
    assert Support.where_issue(@issue).include? @support
  end

  test 'validations' do
    assert_raises(ActiveRecord::RecordInvalid) do
      Support.create!(
        adoption: adoptions(:one),
        position: positions(:one)
      )
    end
  end
end
