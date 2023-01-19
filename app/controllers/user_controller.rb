class UserController < ApplicationController
  before_action :authorize

  def get_current_user
    render json: @current_user, serializer: UserSerializer
  end

  def get_user_profile
    username = params[:username]
    
    if !username
      render json: { "error": "username is required" }, status: :bad_request and return
    end

    user = User.find_by(username: username)

    if user
      render json: user, serializer: UserSerializer
    else
      render json: {"error": "user not found"}, status: :not_found and return
    end
  end

  def get_user_posts
    # default start is 0
    start = params[:start] ? params[:start].to_i : 0

    # default of length is 10, max length is also 10
    length = params[:length] ? (params[:length].to_i > 10 ? 10 : params[:length].to_i) : 10

    # check for invalid arguments
    if start < 0 || length < 0
      render json: { errors: "start and length cannot be negative numbers" }, status: :bad_request and return
    end
    
    username = params[:username]
    user = User.find_by(username: username)
    posts = Post.where(user: user).order(created_at: :desc)
    if start >= posts.length
      render json: [], status: :ok and return
    end

    render json: posts[start, length], each_serializer: PostSerializer, current_user: @current_user
  end

end
