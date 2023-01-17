class AccountController < ApplicationController
  before_action :authorize

  def update_details
    user = @current_user
    user.skip_validations = true
    if user.update(name: params[:name], username: params[:username])
      render json: { message: 'Account updated successfully' }, status: :ok
    else
      render json: { error: user.errors.full_messages }, status: :bad_request
    end
  end

  def update_password
    user = @current_user
    if user&.authenticate(params[:current_password])
      if user.update(password: params[:password],
                     password_confirmation: params[:password_confirmation])
        render json: { message: 'Password updated successfully' }, status: :ok
      else
        render json: { error: user.errors.full_messages }, status: :bad_request
      end
    else
      # unable to authenticate user
      render json: { error: 'Invalid password' }, status: :unauthorized
    end
  end

  def delete_account
    user = @current_user
    if user&.authenticate(params[:password])
      if user.destroy()
        render json: { message: 'Account deleted successfully'}, status: :ok
      else
        render json: { error: user.errors.full_messages }, status: :bad_request
      end
    else
      # unable to authenticate user
      render json: { error: 'Invalid password' }, status: :unauthorized
    end
  end
end
