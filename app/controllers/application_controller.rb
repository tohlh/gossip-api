class ApplicationController < ActionController::API
  SECRET_KEY = ENV["SECRET_KEY_BASE"]

  # Authorize the current user from token
  def authorize
    # reads token from request header
    header = request.headers['Authorization']
    token = header ? header.split(' ').last : ''
    begin
      @decoded_data = jwt_decode(token)
      @current_user = User.find(@decoded_data[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      # user is not found
      render json: { 'errors': e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      # unable to decode token
      render json: { 'errors': e.message }, status: :unauthorized
    end
  end

  private

  def jwt_decode(token)
    decoded = JWT.decode(token, SECRET_KEY, 'HS256')[0]
    HashWithIndifferentAccess.new decoded
  end
end
