require 'httparty'
require 'pp'

class Slack
  include HTTParty
  base_uri "https://slack.com/api"

  def self.send(team, channel, token, text, bot )
    is_text_invalid = (text.nil? or text == "")
    if is_text_invalid
      "cancel sending message"
    else
      query = {
        :team => team,
        :token => token,
        :text => text,
        :channel => channel,
        :username => bot,
      }

      pp post("/chat.postMessage", :query => query)
    end

  end

end
