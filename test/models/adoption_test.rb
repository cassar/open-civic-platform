require 'test_helper'

class AdoptionTest < ActiveSupport::TestCase
  setup do
    @adoption = adoptions(:one)
    @profile = profiles(:one)
    @issue = issues(:one)
    @support = supports(:one)
  end

  test 'associations' do
    assert @adoption.supports.include? @support
    assert @adoption.profile == @profile
    assert @adoption.issue == @issue
  end

  test 'validations' do
    assert_raises(ActiveRecord::RecordInvalid) do
      Adoption.create!(profile: @profile, issue: @issue)
    end
  end
end
