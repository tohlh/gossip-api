class CommentController < ApplicationController
  before_action :authorize

  def get_comments
    post = Post.find_by(id: params[:post_id])
    comments = Comment.where(post_id: params[:post_id]).order(created_at: :desc)
    render json: comments, each_serializer: CommentSerializer, current_user: @current_user
  end

  def create_comment
    post = Post.find_by(id: params[:post_id])
    comment = Comment.new(post: post, user: @current_user, content: params[:content])

    if comment.save
      render json: { message: 'Comment created successfully' }, status: :created
    else
      render json: { errors: tag.errors.full_messages }, status: :bad_request
    end
  end

  def update_comment
    comment = Comment.find_by(id: params[:id])
    if !params[:id]
      render json: { message: 'id is required' }, status: :bad_request
    elsif comment && comment.user == @current_user
      comment.update(content: params[:content])
      render json: { message: 'Comment updated successfully' }, status: :accepted
    elsif comment && comment.user != @current_user
      render json: { message: 'Unauthorized to update comment' }, status: :unauthorized
    else
      render json: { errors: 'Comment does not exist' }, status: :bad_request
    end
  end

  def delete_comment
    comment = Comment.find_by(id: params[:id])
    if !params[:id]
      render json: { message: 'id is required' }, status: :bad_request
    elsif comment && comment.user == @current_user
      comment.destroy
      render json: { message: 'Comment deleted successfully' }, status: :accepted
    elsif comment && comment.user != @current_user
      render json: { message: 'Unauthorized to delete comment' }, status: :unauthorized
    else
      render json: { errors: 'Comment does not exist' }, status: :bad_request
    end
  end
end
