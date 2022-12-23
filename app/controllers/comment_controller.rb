class CommentController < ApplicationController
  before_action :authorize

  def create_comment
    post = Post.find_by(id: params[:post_id])
    comment = Comment.new(post: post, user: @current_user, content: params[:content])

    if comment.save
      render json: { message: 'Comment created successfully' }, status: :created
    else
      render json: { errors: tag.errors.full_messages }, status: :bad_request
    end
  end
end
