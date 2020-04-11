require 'sinatra'
require 'sinatra/json'
require 'erb'
require 'httparty'
require "sqlite3"

#allows the localhost port this webserves runs in to be changed

PORT = 9494
set :port, PORT

#base landing page of localhost:PORT
#redirects to the pokemon stuff so you don't have to remember URL

get "/" do
  redirect "/pokemon/jynx"
end

#just in case someone doesnt type anything in url

get "/pokemon" do
  redirect "/pokemon/jynx"
end

#this is triggered when a blank search is tried
#handled by redirecting to a valid pokemon search

get "/pokemon/" do
  redirect "/pokemon/jynx"
end

#:name notation allows that part of the url to be accessed
#this value is later used for an api call

get "/pokemon/:name" do

  #checks if something was typed into the search bar
  #if there was, redirects to that pokemons site

  if params["search"]
    redirect "/pokemon/#{params["search"].downcase}"
  end

  #gets the info form pokeapi and parses it into a nice object

  response = HTTParty.get("https://pokeapi.co/api/v2/pokemon/#{params["name"].downcase}")
  pokemon_info = response.parsed_response

  #the following if triggers if the api pokeapi query was invalid
  #it then redirects to a valid pokemon

  if pokemon_info == "Not Found"
    redirect "/pokemon/jynx"
  end

  #these @'s allows the values to be accessed by the erb file at the end
  #and everything else is just accessing specifc parts of the pokemon_info object

  @sprite1 = pokemon_info["sprites"]["front_default"] #varchar
  @sprite2 = pokemon_info["sprites"]["back_default"] #varchar
  @id = pokemon_info["id"] #int
  @name = pokemon_info["name"] #varchar
  @types = pokemon_info["types"] #array of varchar
  @height = pokemon_info["height"] #float
  @weight = pokemon_info["weight"] #float

  #returns the erb file to the person who triggered the GET request
  #in a browser this will display as html/css

  erb :pokemon_selected
end

#planned

#add shiny_sprites
#add base_stats
#add multiple pages that link to each other (api has good features for this)