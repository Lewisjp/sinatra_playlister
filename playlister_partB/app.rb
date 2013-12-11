require './parser'
require './lib/artist'
require './lib/song'
require './lib/genre'

class App

  attr_accessor :which_artist, :artists_total_songs, :artists_total_songs_display, :songs_display_genre, 
      :discography, :catalog, :parser, :artist_song

  def initialize(user_choice)
    @parser = Parser.new
    @catalog = parser.parse_songs 
    @which_artist = user_choice.to_s

    #print out a list of songs and genres for that artist
    @artists_total_songs = 1  # keeps track of songs
    @artists_total_songs_display = [] # keeps track of song names 
    @songs_display_genre = [] #keeps track of song's genre
      @artist_song = catalog.each do |file|  #= [[artist,song,genre]]
        if file[0] == which_artist.capitalize
#          artists_total_songs += 1 
          artists_total_songs_display << file[1] 
          songs_display_genre << file[2]
        end
      end

  end

  def pull_artist_songs

    which_artist + " - " + artists_total_songs_display.length.to_s + " Songs"
  end

  def display_artist_songs
    artists_total_songs_display.length.times do | i |
       artists_total_songs_display[i] + " - " + songs_display_genre[i]
    end
  end

  def display_genres(catalog)    
      discography = {   #Tally of genres and songs 
        "dance" => 0, 
        "indie" => 0,
        "folk" => 0,
        "country" => 0,
        "pop" => 0,
        "hip-hop" => 0,
        "rock" => 0,
        "house" => 0,
        "rap" => 0,
        "electro" => 0
      }

      catalog.each do |file|  # Genre count from parse 
        discography[file[2]] += 1
      end      
     


      discography = discography.sort_by { |key,value| value} # sort hash by least to most 
      puts "Genres:" 


      discography.each do | key, value|


        puts "#{key.capitalize}: #{value} Songs" #, ? Artists" 
      end
      discography
  end

  def select_genre(discography, catalog)
    valid_genre = false 
    puts "Select a Genre"
    which_genre = gets.chomp.downcase

    discography.each do |x|
      if x.include?(which_genre)
        valid_genre = true
      end
    end

    if valid_genre == true 
      return which_genre 
    else
      puts "Please select from a valid Genre."
      select_genre(discography, catalog)
    end
  end 


  def all_artists(catalog)

      #print list of all unique artists alphab with song count
      new_catalog = []
      
      catalog.each do |file|  # Gets data from parse 
        new_catalog << file[0]

      end
      new_catalog.uniq!
      puts new_catalog
      puts "There are #{new_catalog.count} artists in this list."    
      new_catalog
  end


  def genre_page(which_genre, discography, catalog)
      #the genres page should list the name of the songs, linking to the individual song and artists 
      #Also include the total unique artists and song counts in the genre
      puts "The genre_pages are in development."


  end

  def browsing
    puts "Browse by artist or genre"
    browse_choice = gets.chomp.downcase
    parser = Parser.new
    catalog = parser.parse_songs #nested array w/in array [artist, song, genre]



    if browse_choice == "artist"

      all_artists(catalog)

      puts "Select an artist"
      which_artist = gets.chomp.capitalize

      pull_artist_songs(which_artist, catalog) # This method will call the display method 
     


    elsif browse_choice == "genre"
      #print list of all genres sorted by the amount of songs
      # the number of songs and number artists per genre should be included
      # artists in progress 
      discography = display_genres(catalog)   

      # verify valid genre selected
      which_genre = select_genre(discography, catalog)

      #taken to the individual genre "page"
      genre_page(which_genre, discography, catalog)
      




      #a user should be able to type artist name M83 and be taken to M83's artist "page" 
      #or type song name Midnight City and get taken to the songs "page"
      #the song page should list all the available info on the song, it's artist and genre.
    else
      puts "Sorry I did not understand"
      browsing
    end
  end

  def testa


  end

  def testb
 
  end

  def testc #stops working 

 #     which_artist.class => string
 #      artist_song[-2][0].class  => string

artists_total_songs_display
  end 
  
  def testd

#          artist_song[-2][0].inspect => "Yuck"
#          artist_song[-2][0].downcase = "yuck"
#            artist_song[-2][0].downcase.capitalize => "Yuck"
songs_display_genre

  end

  def teste
    artists_total_songs_display[0] + " - " + songs_display_genre[0].capitalize
        artists_total_songs_display[1] + " - " + songs_display_genre[1].capitalize
  end

end



