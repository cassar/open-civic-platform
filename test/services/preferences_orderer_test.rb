require 'test_helper'

class PreferencesOrdererTest < ActiveSupport::TestCase
  setup do
    @orderer = PreferencesOrderer.new(supports(:three), 1)
  end

  test 'order!' do
    assert supports(:three).preference == 3
    assert supports(:two).preference == 1
    assert supports(:four).preference == 2
    @orderer.order!
    assert supports(:three).reload.preference == 1
    assert supports(:two).reload.preference == 2
    assert supports(:four).reload.preference == 3
  end
end
