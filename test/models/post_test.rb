require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "Add Post" do
    user = User.find_by(username: 'user1')
    post = Post.new(title: 'Some cool title', content: 'Some cool content', user: user)
    assert post.save
  end

  test "Invalid user post" do
    user = nil
    post = Post.new(title: 'Some cool title', content: 'Some cool content', user: user)
    assert_not post.save
  end
end
