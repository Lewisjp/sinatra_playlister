require "./app.rb"
require 'bundler'
Bundler.require
require './lib/artist'
require './lib/song'
require './lib/genre'
require './parser'

module Jukebox
	class Playlister < Sinatra::Application

	get '/artists/:artist' do
		@playlister = Parser.new
		@playlister.all_artists.each do |artist|
			artist.name
		end
	end
end

end