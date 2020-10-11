require 'test_helper'

class LinkTest < ActiveSupport::TestCase
  test 'should reject bad links' do
    assert_not Link.create(url: 'xxx').persisted?
  end

  test 'should accept good links' do
    assert Link.create(url: 'http://stackoverflow.com').persisted?
  end
end
