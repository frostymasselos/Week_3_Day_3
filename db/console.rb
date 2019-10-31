require("pry")
require_relative("../models/artists")
require_relative("../models/albums")


artist1 = Artists.new( {'artist_name' => 'Jimmy Hendrix'})
artist1.save
artist2 = Artists.new( {'artist_name' => 'Eric Clapton'})
artist2.save

album1 = Albums.new ({'album_name' => 'Woodstock', 'genre' => 'rock', 'artist_id' => artist1.id})
album1.save

binding.pry
nil
