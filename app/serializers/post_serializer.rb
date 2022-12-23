class PostSerializer < PostsSerializer
  has_many :comments
end
