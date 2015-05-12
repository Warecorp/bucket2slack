require 'sinatra'
require 'json'
require 'haml'
require 'yaml'

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }

CONFIG = YAML::load_file 'config.yml'

helpers do
  def forward_action (payload, team, channel = nil)
    channel = "##{channel ? channel : default_channel(team)}"
    bot = channel.delete("#").delete("_") + "bot"
    text = Parser.process(payload)
    if text
      response = Slack.send(team_host(team), channel, token(team), text, bot )
      response.to_json
    else
      halt 503, "Can't forward the requests."
    end
  end

  def default_channel team
    CONFIG[team]['default_channel'] || "general"
  end

  def token team
    CONFIG[team]['token']
  end

  def team_host team
    CONFIG[team]['team']
  end

end


get '/' do
  readme = File.read "README.md"
  options = { autolink: true, tables: true }
  haml :index, :locals => { :text => markdown(readme, options) }
end

post '/:team' do |team|
  content_type :json
  payload = JSON.parse request.body.read
  forward_action payload, team
end

post '/:team/:channel' do |team, channel|
  content_type :json
  payload = JSON.parse request.body.read
  forward_action payload, team, channel
end
