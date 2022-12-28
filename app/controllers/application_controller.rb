class ApplicationController < ActionController::API
  SECRET_KEY = ENV["SECRET_KEY_BASE"]

  def jwt_encode(payload)
    payload[:exp] = 24.hours.from_now.to_i		# token expires in 24h
    JWT.encode(payload, SECRET_KEY, 'HS256')	# encode payload into token
  end

  def jwt_decode(token)
    decoded = JWT.decode(token, SECRET_KEY, 'HS256')[0]
    HashWithIndifferentAccess.new decoded
  end

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
end
