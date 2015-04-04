require 'sinatra'
require 'json'

require_relative 'parser'
require_relative 'slack'

def forward_action (payload, channel)
  channel = "##{channel}"
  bot = channel.delete("#", "_") + "bot"
  text = Parser.process(payload)
  response = Slack.send( channel, text, bot )
  response.to_json
end

get '/' do
  "Post to this URL"
end

post '/' do
  content_type :json
  payload = JSON.parse request.body.read
  forward_action payload, "pull_requests"
end

post '/:channel' do |channel|
  content_type :json
  payload = JSON.parse request.body.read
  forward_action payload, channel
end
