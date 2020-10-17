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

  test 'should accept good links and save title' do
    url = 'http://stackoverflow.com'
    title = 'stackoverflow'

    LinkThumbnailer.expects(:generate)
      .with(url)
      .returns(Struct.new(:title).new(title))

    assert Link.create(
      url: url,
      linkable: issues(:one)
    ).persisted?

    assert Link.last.title == title
  end
end
