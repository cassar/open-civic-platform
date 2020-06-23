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

  test 'support associations' do
    assert @support.adoption == @adoption
    assert @support.position == @position
    assert @support.issue == @issue
    assert @support.profile == @profile
    assert @support.user == @user
  end

  test 'support scopes' do
    assert Support.subscribed.include? @support
    assert Support.subscribed.exclude? supports(:two)

  test 'validations' do
    assert_raises(ActiveRecord::RecordInvalid) do
      Support.create!(
        adoption: adoptions(:one),
        position: positions(:one)
      )
    end
  end
end
