class PostController < ApplicationController
  before_action :authorize

  def create_post
    # step 1, save the post first
    post = Post.new(
      title: params[:title],
      content: params[:content],
      user: @current_user
    )
    if !post.save
      render json: { errors: post.errors.full_messages }, status: :bad_request
    end

    for t in params[:tags] do
      # step 2, check if the tag already existed
      tag = Tag.new(title: t.downcase)
      if Tag.exists?(title: t.downcase)
        # step 2.1, if yes, retrieve it
        tag = Tag.find_by(title: t.downcase)
      elsif !tag.save
        # step 2.2, if not, save it
        render json: { errors: tag.errors.full_messages }, status: :bad_request
      end
      
      # step 3, save as many-to-many relation with TagAssignment
      tag_assignment = TagAssignment.new(post: post, tag: tag)
      if !tag_assignment.save
        render json: { errors: tag.errors.full_messages }, status: :bad_request
      end
    end

    render json: { message: 'Post created successfully'}, status: :created
  end
end
