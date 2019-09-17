require 'json'
require 'socket'
require './twitch_bot_class.rb'

def parse_json_sym_keys(f)
    JSON.parse(File.read(f), :symbolize_names => true)
end
config = Hash.new
config = parse_json_sym_keys("config/config.json")

# CONSTANT VARIABLES

TWITCH_OAUTH_TOKEN, TWITCH_BOT_NAME, TWITCH_CHANNEL = 
    config[:key],
    config[:name],
    config[:channel_name]

# END
puka = Twitch_Bot.new
puka.run(TWITCH_OAUTH_TOKEN, TWITCH_BOT_NAME, TWITCH_CHANNEL)

