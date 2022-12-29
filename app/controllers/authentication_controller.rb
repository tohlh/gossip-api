class AuthenticationController < ApplicationController
  # user login
  def login
    user = User.find_by('username': params[:username])
    if user&.authenticate(params[:password])
      # user is authenticated and token is generated
      token = jwt_encode('user_id': user.id)
      render json: { token: token }, status: :ok
    else
      # unable to authenticate user
      render json: { error: 'Invalid username or password' }, status: :unauthorized
    end
  end

  # user sign up
  def signup
    # creates a new user
    user = User.new(signup_params)
    if user.save
      render json: { message: 'User created successfully' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

	private

  def jwt_encode(payload)
    payload[:exp] = 24.hours.from_now.to_i		# token expires in 24h
    JWT.encode(payload, SECRET_KEY, 'HS256')	# encode payload into token
  end

  def signup_params
    params.permit(:name, :username, :password, :password_confirmation)
  end
end
