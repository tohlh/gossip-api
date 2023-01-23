class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :is_edited, :is_op, :created_at
  belongs_to :user, serializer: UserSerializer
  has_many :tags, serializer: TagSerializer

  def tags
    object.tags.order("title")
  end

  def is_edited
    object.created_at != object.updated_at
  end

  def is_op
    object.user == @instance_options[:current_user]
  end
end
