class SongsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  def index
  	songs = Song.all
	  render json: { data: songs }, status: 200
  end
end