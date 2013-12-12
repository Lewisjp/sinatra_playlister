require 'bundler'
Bundler.require
require './lib/parser'

module JukeBox
	class App < Sinatra::Application


	get '/:reply' do
		@playlister = Parser.new("./data")
		erb :all
	end

	get '/artist/:name' do
	  @playlister = Parser.new("./data")
	  @artist = @playlister.find_artist(params[:name])
	  erb :artist
  end

  get '/genre/:name' do
    @playlister = Parser.new("./data")
    @genre = @playlister.find_genre(params[:name]) 
    erb :genre
  end

  get '/song/:name' do
    @playlister = Parser.new("./data")
    @song = playlister.find_song(params[:name])
    erb :song
  end 
	

	helpers do
		
		def intermediate_partial(template, locals=nil)
			locals = locals.is_a?(Hash) ? locals : {template.to_sym => locals}
			template = :"_#{template}"
			erb template, {}, locals        
		end

		def adv_partial(template,locals=nil)
			if template.is_a?(String) || template.is_a?(Symbol)
				template = :"_#{template}"
			else
				locals=template
				template = template.is_a?(Array) ? :"_#{template.first.class.to_s.downcase}" : :"_#{template.class.to_s.downcase}"
			end
			if locals.is_a?(Hash)
				erb template, {}, locals      
			elsif locals
				locals=[locals] unless locals.respond_to?(:inject)
				locals.inject([]) do |output,element|
					output << erb(template,{},{template.to_s.delete("_").to_sym => element})
				end.join("\n")
			else 
				erb template
			end
		end
	end
	end
end