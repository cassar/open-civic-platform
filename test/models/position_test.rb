require 'test_helper'

class PositionTest < ActiveSupport::TestCase
  setup do
    @position = Position.first
    @issue = Issue.first
    @support = Support.first
    @adoption = adoptions(:one)
    @profile = profiles(:one)
  end

  test 'associations' do
    assert @position.supports.include? @support
    assert @position.adoptions.include? @adoption
    assert @position.supporting_profiles.include? @profile
    @position.destroy
    assert_raises(ActiveRecord::RecordNotFound) { @support.reload }
  end

  test 'scopes' do
    assert Position.all.where_issue(@issue).include? @position
  end

  test 'validations' do
    assert_not @position.update name: nil
  end

  test 'generate identifier callback' do
    position = Position.new(name: 'I agree')
    position.validate
    assert position.identifier == 'i_agree'
  end
end
