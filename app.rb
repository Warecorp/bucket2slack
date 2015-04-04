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
    
    # response = Slack.send( channel, text, bot )
    # response.to_json
  end
end


get '/' do
  "Bitbucket PR => Slack!\nSet your bitbucket's Pull Request URL Hook to this URL."
end

get '/unauthorized' do
  "Token doesn't exist".to_json
end

post '/' do
  content_type :json
  payload = JSON.parse request.body.read
  forward_action payload, "testapi"
end

post '/:channel' do |channel|
  content_type :json
  payload = JSON.parse request.body.read
  forward_action payload, channel
end
