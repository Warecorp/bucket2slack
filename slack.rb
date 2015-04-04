require 'httparty'
require 'pp'

class Slack
  include HTTParty
  base_uri "https://slack.com/api"

  def self.send( text )
    post("/chat.postMessage", :query => {
      :team => "redant",
      :token => "xoxp-2530341512-3838583146-4293642966-7e7606",
      :channel => "#testapi",
      :text => text,
      :username => "harrodsbot",
    })
  end
  
end
