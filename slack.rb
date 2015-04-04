require 'httparty'

class Slack
  include HTTParty
  base_uri "https://slack.com/api"

  def self.send( channel, text, bot, bot_avatar_uri )
    is_text_invalid = (text.nil? or text == "")
    if is_text_invalid
      "cancel sending message"
    else
      query = {
        :team => "redant",
        :token => "xoxp-2530341512-3838583146-4293642966-7e7606",
        :text => text,
        :channel =>  channel || "#testapi",
        :username => bot || "slackbucketbot",
      }
      query[:bot_avatar_uri] = bot_avatar_uri if !bot_avatar_uri.nil?

      post("/chat.postMessage", :query => query)
    end

  end

end
