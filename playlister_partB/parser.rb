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
  def initialize
    parse_songs
  end

  def parse_songs
    files = Dir.entries('data').select { |f| !File.directory? f}
    artist = /((.*) (?=\-))/
    song = /(?<=\-\s).*(?=\s\[)/
    genre = /(?<=\[).*(?=\])/
    catalog = []
    files.each do |item|
      song_array = []
      a = item.match(artist).to_s.strip
      s = item.match(song).to_s
      g = item.match(genre).to_s
      song_array << a << s << g
      catalog << song_array
    end
    catalog
  end

  def all_artists
    Artist.all
  end


  #  files = Dir.entries('data').select { |f| !File.directory? f}
  # ap parse_songs(files)
end



