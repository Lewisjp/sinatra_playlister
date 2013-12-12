require_relative 'artist'
require_relative 'song'
require_relative 'genre'
require_relative 'parser'

parse_directory(File.join(Dir.pwd,'data'))

puts "Welcome to the playlist!!!"
puts "Please enter a command:"
command = ""

while command != 'exit'
  command = gets.downcase.strip

  case command
  when 'help'
    puts "I respond to: "
    puts "browse <type> - browse aritsts, genres, songs"
    puts "or once you've selected a type, <type> number"
    puts "for example 'artist 7'"
  when /(genre|artist|song) \d+/
    type = command.split.first.strip.downcase
    index = command.split.last.strip.downcase.to_i
    case type
    when "artist"
      Artist.list_songs(index)
    when "genre"
      Genre.list_songs(index)
    when "song"
      Song.play(index)
    end
  when /browse/
    type = command.split.last.strip.downcase[0..-2] #remove last letter
    case type
    when "genre"
      Genre.list
    when "artist"
      Artist.list
    when "song"
      Song.list
    end
  end
end

puts "Goodbye!"



