require "bundler"
Bundler.require :default, :server, (ENV["RACK_ENV"] || "development").to_sym


