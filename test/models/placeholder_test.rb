require 'test_helper'

class PlaceholderTest < ActiveSupport::TestCase
  setup do
    @placeholder = Placeholder.first
    @profile = Profile.second
  end

  test 'placeholder associations' do
    assert @placeholder.profile == @profile
  end

  test 'placeholder validations' do
    assert_not @placeholder.update email: nil
  end
end
