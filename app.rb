require 'sinatra'
require 'dotenv'
require 'json'
require './parser'
require './slack'

Dotenv.load

before do
  team_exists = !ENV['SLACK_TEAM'].nil? and ENV['SLACK_TEAM'] != ""
  token_exists = !ENV['SLACK_TOKEN'].nil? and ENV['SLACK_TOKEN'] != ""
  halt 401, "Make sure to set slack's team and token id..." unless token_exists and team_exists
end

helpers do
  def forward_action (payload, channel)
    channel = "##{channel}"
    bot = channel.delete("#").delete("_") + "bot"
    text = Parser.process(payload)
    if text
      response = Slack.send( channel, text, bot )
      response.to_json
    else
      halt 503, "Can't forward the requests."
    end
  end
end


get '/' do
  "<h3>Bitbucket PR => Slack!</h3>
   <p>Set your bitbucket's Pull Request URL Hook to this URL.</p>"
end

get '/unauthorized' do
  "Token doesn't exist".to_json
end

post '/' do
  content_type :json
  payload = JSON.parse request.body.read
  default_channel = ENV['SLACK_DEFAULT'] || "general"
  forward_action payload, default_channel
end

post '/:channel' do |channel|
  content_type :json
  payload = JSON.parse request.body.read
  forward_action payload, channel
end
