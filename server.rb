require "bundler"
require "yaml"
Bundler.require :default, :server, (ENV["RACK_ENV"] || "development").to_sym
settings = YAML.load_file("config.yml").to_hashugar

get "/" do
  @settings = settings
  erb :index
end

get "/pretty" do
  erb :pretty
end

get "/proxy/feed.:format" do
  headers "Access-Control-Allow-Origin" => "*"
  
  feed = Typhoeus.get "https://raw.github.com/gist/#{settings.github.gist}/feed.json"
  
  unless feed.code == 200
    status feed.code
    return feed.body
  end
  
  case params[:format]
    when "json"
      headers "Content-type" => "application/json"
      feed.body
    when "jsonp"
      headers "Content-type" => "application/javascript"
      cb = params["callback"] || "callback"
      cb = "callback" if cb == ""
      "#{cb}(#{feed.body});"
    when "yaml"
      headers "Content-type" => "application/x-yaml"
      YAML.dump JSON.load feed.body
    else
      status 400
      "bad format"
  end
end
