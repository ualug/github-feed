require "bundler"
require "yaml"
Bundler.require :default, :fetcher

settings = YAML.load_file("config.yml").to_hashugar
github = Github.new

# Fetch all feeds from all members of the
# organisation, except those in the config's
# feed.ignore array.

members = github.orgs.members.list settings.github.org
org_feed = []
members.each do |member|
  unless settings.feed.ignore.include? member.login
    member_feed = github.events.list_user_performed member.login
    member_feed.each do |ev|
      org_feed.push ev
    end
  end
end

# Sort the feed by date and pick only
# the last N items, as defined in the
# config's feed.length property.

org_feed = (org_feed.sort_by! { |a| a.created_at }).last settings.feed.length
IO.write "github.json", org_feed.to_json
