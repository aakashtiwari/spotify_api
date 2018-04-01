class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :album
      t.text :tags, array:true, default: []
      t.string :release_date
      t.string :artist
      t.string :description
      t.integer :star_rating
      t.string :image_url

      t.timestamps null: false
    end
  end
end
