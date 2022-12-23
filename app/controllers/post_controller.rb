class PostController < ApplicationController
  before_action :authorize

  def get_posts
    # default start is 0
    start = params[:start] ? params[:start].to_i : 0

    # default of length is 10, max length is also 10
    length = params[:length] ? (params[:length].to_i > 10 ? 10 : params[:length].to_i) : 10

    # check for invalid arguments
    if start < 0 || length < 0
      render json: { errors: "start and length cannot be negative numbers" }, status: :bad_request and return
    end

    posts = Post.all[start, length]
    render json: posts, each_serializer: PostsSerializer, root: posts, current_user: @current_user
  end

  def create_post
    # step 1, save the post first
    post = Post.new(
      title: params[:title],
      content: params[:content],
      user: @current_user
    )
    if !post.save
      render json: { errors: post.errors.full_messages }, status: :bad_request and return
    end

    for t in params[:tags] do
      # step 2, check if the tag already existed
      tag = Tag.new(title: t.downcase)
      if Tag.exists?(title: t.downcase)
        # step 2.1, if yes, retrieve it
        tag = Tag.find_by(title: t.downcase)
      elsif !tag.save
        # step 2.2, if not, save it
        render json: { errors: tag.errors.full_messages }, status: :bad_request and return
      end

      # step 3, save as many-to-many relation with TagAssignment
      tag_assignment = TagAssignment.new(post: post, tag: tag)
      if !tag_assignment.save
        render json: { errors: tag.errors.full_messages }, status: :bad_request and return
      end
    end

    render json: { message: 'Post created successfully' }, status: :created and return
  end

  def delete_post
    post = Post.find_by(id: params[:id])
    if post && post.user == @current_user
      post.destroy
      render json: { message: 'Post deleted successfully' }, status: :accepted and return
    elsif post && post.user != @current_user
      render json: { message: 'Unauthorized to delete post' }, status: :unauthorized and return
    else
      render json: { errors: 'Post does not exist' }, status: :bad_request and return
    end
  end
end
