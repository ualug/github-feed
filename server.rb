require "bundler"
require "yaml"
Bundler.require :default, :server
settings = YAML.load_file("config.yml").to_hashugar

get "/" do
  @settings = settings
  erb :index
end

get "/pretty" do
  erb :pretty
end

get "github.:format" do
  headers "Access-Control-Allow-Origin" => "*"
  feed = IO.read "feed.json"

  case params[:format]
    when "json"
      headers "Content-type" => "application/json"
      feed
    when "jsonp"
      headers "Content-type" => "application/javascript"
      cb = params["callback"] || "callback"
      cb = "callback" if cb == ""
      "#{cb}(#{feed});"
    when "yml"
      headers "Content-type" => "text/x-yaml"
      YAML.dump JSON.load feed
    else
      status 400
      "bad format"
  end
end
