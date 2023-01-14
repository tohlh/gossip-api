class AccountController < ApplicationController
  before_action :authorize

  def update_account
    user = @current_user
    if user&.authenticate(params[:current_password])
      if user.update(account_params)
        render json: { message: 'Account updated successfully' }, status: :ok
      else
        render json: { error: user.errors.full_messages }, status: :bad_request
      end
    else
      # unable to authenticate user
      render json: { error: 'Invalid password' }, status: :unauthorized
    end
  end

  def account_params
    params.permit(:name, :username, :password, :password_confirmation)
  end
end
