require 'sinatra'
require 'sinatra/json'
require 'erb'
require 'httparty'

PORT = 9494

set :port, PORT

set(:query) { |val| condition { request.query_string == val } }

get "/pokemon" do
  redirect "/pokemon/jynx"
end

get "/pokemon/" do
  redirect "/pokemon/jynx"
end

get "/pokemon/:name" do
  if params["search"]
    redirect "/pokemon/#{params["search"].downcase}"
  end

  response = HTTParty.get("https://pokeapi.co/api/v2/pokemon/#{params["name"].downcase}")

  pokemon_info = response.parsed_response

  p pokemon_info

  if pokemon_info == "Not Found"
    redirect "/pokemon/jynx"
  end

  pokemon_info["sprites"]["front_default"]

  @sprite1 = pokemon_info["sprites"]["front_default"]
  @sprite2 = pokemon_info["sprites"]["back_default"]
  @id = pokemon_info["id"]
  @name = pokemon_info["name"]
  @types = pokemon_info["types"]
  @height = pokemon_info["height"]
  @weight = pokemon_info["weight"]

  erb :pokemon_selected
end
