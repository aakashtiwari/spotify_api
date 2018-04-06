class UsersController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  skip_before_action :authenticate_request, :only => [:create]

  def index
  	songs = Song.all
		render json: { data: songs }, status: 200
  end

  def show
  	song = Song.find(params[:id])
  	render json: { data: song }, status: 200
  end

  def update
  	song = Song.find(params[:id])
  	if song.update_attributes(update_song_params)
  		render json: { data: {"success": "Successfully Updated"} }, status: 200
		else
	  	render json: { error: exception.message }, status: 400
	  end
  end

  def destroy
  	song = Song.find(params[:id])
  	if song.destroy
  		render json: { data: {"success": "Successfully deleted"} }, status: 200
		else
	  	render json: { error: exception.message }, status: 400
	  end
  end

  def create
    params[:user][:password] = params[:password]
    if User.create(user_params)
      authenticate_user
      render json: { data: {"success": "Successfully Updated"} }, status: 200
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
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

end
