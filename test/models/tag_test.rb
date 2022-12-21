require "test_helper"

class TagTest < ActiveSupport::TestCase
  test "valid tag" do
    tag = Tag.new(title: 'some_cool_tag_0')
    assert tag.save
  end

  test "invalid caps tag" do
    tag = Tag.new(title: 'SOME_COOL_TAG')
    assert_not tag.save
  end

  test "invalid symbols tag" do
    tag = Tag.new(title: 'some-cool-tag')
    assert_not tag.save
  end

  test "tag too short" do
    tag = Tag.new(title: 'a')
    assert_not tag.save
  end

  test "tag too long" do
    tag = Tag.new(title: 'abcdefghijklmnopqrstuvwxyzabc')
    assert_not tag.save
  end
end
