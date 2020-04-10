require 'sinatra'
require 'sinatra/json'
require 'erb'
require 'httparty'

PORT = 9494

set :port, PORT

get "/pokemon" do
    return "test"
end

get "/pokemon/:name" do
    response = HTTParty.get("https://pokeapi.co/api/v2/pokemon/#{params["name"]}")

    thing = response.parsed_response

    stats = []
    abilities = []

    name = thing["name"]

    id = thing["id"]
    puts "#{name} has id: #{id}"
    
    i = 0
    while i < 6
        statname = thing["stats"][i]["stat"]["name"]
        statval = thing["stats"][i]["base_stat"]
        stats[i] = {name: statname, val: statval}
        puts "base #{statname}: #{statval}"
        i += 1
    end
    
    i = 0
    while i < thing["abilities"].length
        abilityname = thing["abilities"][i]["ability"]["name"]
        abilities << abilityname
        puts "has ability #{abilityname}"
        i += 1
    end

    @name = name
    @id = id
    @stats = stats
    @abilities = abilities
    erb :pokemon_selected
end
