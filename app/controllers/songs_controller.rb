class SongsController < ApplicationController
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
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
  	if Song.create(update_song_params)
  		render json: { data: {"success": "Successfully Updated"} }, status: 200
		else
	  	render json: { error: exception.message }, status: 400
	  end
  end

  private
   def update_song_params
    	params.require(:song).permit(:id, :name, :album, :release_date, :artist, :description, :star_rating, :image_url, tags: [])
   end
end
