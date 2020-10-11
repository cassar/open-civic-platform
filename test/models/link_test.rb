require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  test 'associations' do
    assert links(:stackoverflow).linkable == issues(:one)
  end

  test 'should reject bad links' do
    assert_not Link.create(
      url: 'xxx',
      linkable: issues(:one)
    ).persisted?
  end

  test 'should accept good links' do
    assert Link.create(
      url: 'http://stackoverflow.com',
      linkable: issues(:one)
    ).persisted?
  end
end
