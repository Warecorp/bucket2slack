require 'sinatra'
require 'json'
require 'logger'
require 'mail'

require_relative 'parser'
require_relative 'slack'

get '/' do
  "Post to this URL"
end

post '/' do
  content_type :json

  payload = JSON.parse request.body.read
  puts payload

  parsed = Parser.process(payload)

  channel = '#testapi'
  bot =  'harrodsbot'
  text = parsed[:text]
  bot_avatar_uri = parsed[:bot_avatar_uri]
  Slack.send( channel, text, bot, bot_avatar_uri )

end
