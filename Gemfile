source :rubygems
ruby "1.9.3"

gem "hashugar"
gem "json"

group :fetcher do
  gem "github_api"
end

group :server do
  gem "sinatra"
  gem "httparty"
end

group :production do
  gem "unicorn", require: false
end

group :development do
  gem "thin", require: false
  gem "foreman", require: false
  gem "heroku", require: false
end
