require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

exchange_rate_API = ENV.fetch("EXCHANGE_RATE_KEY")
base_URL = "https://api.exchangerate.host/"

# define a route
get("/") do

  # build the API url, including the API key in the query string
  api_url = "#{base_URL}list?access_key=#{exchange_rate_API}"

  # use HTTP.get to retrieve the API information
  raw_data = HTTP.get(api_url)

  # convert the raw request to a string
  raw_data_string = raw_data.to_s

  # convert the string to JSON
  parsed_data = JSON.parse(raw_data_string)

  # get the symbols from the JSON
  @symbols = parsed_data["currencies"]

  # render a view template where I show the symbols
  erb(:homepage)
end

