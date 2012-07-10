require "bundler"
Bundler.require :default, :server, (ENV["RACK_ENV"] || "development").to_sym
settings = YAML.load_file("config.yml").to_hashugar

get '/' do
  @settings = settings
  erb :index
end

get '/pretty' do
  erb :pretty
end
