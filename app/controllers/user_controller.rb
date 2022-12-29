class UserController < ApplicationController
  before_action :authorize

  def get_user
    render json: @current_user, serializer: UserSerializer
  end
end
