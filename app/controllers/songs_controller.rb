class SongsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  def index
  	binding.pry
  	songs = Song.all
	  render json: { songs: songs }, status: 200
  end
end