class ApplicationController < ActionController::API
  SECRET_KEY = ENV["SECRET_KEY_BASE"]

  def authorize
    # reads token from request header
    header = request.headers['Authorization'].split(' ').last
    begin
      @decoded_data = jwt_decode(header)
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
