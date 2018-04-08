class UsersController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  skip_before_action :authenticate_request, :only => [:create]

  def create
    params[:user][:password] = params[:password]
    if User.create(user_params)
      authenticate_user
    else
      render json: { error: exception.message }, status: 400
    end
  end

  private

  def user_params
  	params.require(:user).permit(:id, :username, :first_name, :last_name, :password)
  end

  def authenticate_user
    command = AuthenticateUser.call(params[:username], params[:password])
    if command.success?
      render json: { auth_token: command.result }, status: 200
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

end
