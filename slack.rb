require 'httparty'
require 'pp'

class Slack
  include HTTParty
  base_uri "https://slack.com/api"

  def self.send( channel, text, bot )
    is_text_invalid = (text.nil? or text == "")
    if is_text_invalid
      "cancel sending message"
    else
      query = {
        :team => ENV['SLACK_TEAM'],
        :token => ENV['SLACK_TOKEN'],
        :text => text,
        :channel =>  channel || "#testapi",
        :username => bot || "slackbucketbot",
      }

      pp post("/chat.postMessage", :query => query)
    end

  end

end
