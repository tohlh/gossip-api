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

    posts = Post.all.order(created_at: :desc)[start, length]
    tag = Tag.find_by(title: params[:tag])
    
    if params[:tag]
      tag_assignments = TagAssignment
                          .where(tag: tag)
                          .joins(:post)
                          .order('posts.created_at DESC')
      posts = tag_assignments.map{ |t| t.post }
    end

    render json: posts, each_serializer: PostSerializer, current_user: @current_user
  end

  def get_post
    post = Post.find_by(id: params[:id])
    if !params[:id]
      render json: { errors: 'id is required' }, status: :bad_request
    elsif post
      render json: post, serializer: PostSerializer, current_user: @current_user
    else
      render json: { errors: 'Post does not exist' }, status: :bad_request
    end
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

    render json: { message: 'Post created successfully' }, status: :created
  end

  def update_post
    post = Post.find_by(id: params[:id])
    if !params[:id]
      render json: { message: 'id is required' }, status: :bad_request
    elsif post && post.user == @current_user
      post.update(title: params[:title], content: params[:content])
      render json: { message: 'Post updated successfully' }, status: :accepted
    elsif post && post.user != @current_user
      render json: { message: 'Unauthorized to update post' }, status: :unauthorized
    else
      render json: { errors: 'Post does not exist' }, status: :bad_request
    end
  end

  def delete_post
    post = Post.find_by(id: params[:id])
    if !params[:id]
      render json: { message: 'id is required' }, status: :bad_request
    elsif post && post.user == @current_user
      post.destroy
      render json: { message: 'Post deleted successfully' }, status: :accepted
    elsif post && post.user != @current_user
      render json: { message: 'Unauthorized to delete post' }, status: :unauthorized
    else
      render json: { errors: 'Post does not exist' }, status: :bad_request
    end
  end
end
