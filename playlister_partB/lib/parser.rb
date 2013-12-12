require './lib/artist'
require './lib/song'
require './lib/genre'

# artist = /((.*) (?=\-))/
# song = /(?<=\-\s).*(?=\s\[)/
# genre = /(?<=\[).*(?=\])/

# our_artist = files[0].match(artist)
# our_song = files[0].match(song)
# our_genre = files[0].match(genre)
class Parser

def initialize(directory_name)
  songs = Dir.entries(directory_name).delete_if{|str| str[0] == "."}
  songs.each do |filename|
    artist_name = filename.split(" - ")[0]
    song_name = filename.split(" - ")[1].split("[")[0].strip
    genre_name = filename.split(" - ")[1].split(/\[|\]/)[1]

    artist = Artist.find_by_name(artist_name) || Artist.new.tap{|a| a.name = artist_name}

    song = Song.new
    song.name = song_name

    genre = Genre.find_by_name(genre_name) || Genre.new.tap{|g| g.name = genre_name}

    song.genre = genre
    artist.add_song(song)
  end
end

  def all_artists
    Artist.all
  end

  def all_genres
    Genre.all
  end

   def all_songs
    Song.all
  end

  def find_artist(name)
    Artist.find_by_name(name)
  end

  def find_song(name)
    Song.find_by_name(name)
  end

  def find_genre(name)
    Genre.find_by_name(name)
  end





  #  files = Dir.entries('data').select { |f| !File.directory? f}
  # ap parse_songs(files)
end



