class PostsSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :edited, :deleteable
  belongs_to :user, serializer: UserSerializer
  has_many :tags, serializer: TagsSerializer

  def edited
    object.created_at != object.updated_at
  end

  def deleteable
    object.user == @instance_options[:current_user]
  end
end
