class TagController < ApplicationController
  before_action :authorize

  # Get the top 20 most used tags
  def get_tags
    counts = TagAssignment.select(:tag_id).group(:tag_id).order('count(tag_id) DESC')[0, 20]
    tags = counts.map{|count| count.tag}
    render json: tags, each_serializer: TagSerializer
  end
end
