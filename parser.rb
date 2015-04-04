require 'logger'

class Parser
  @actions = [
    "updated",
  ]

  def self.process( payload )

    action = @actions.select { |act| payload.has_key? "pullrequest_"+act }.first
    is_method_exists = !action.nil? and self.respond_to? action

    if is_method_exists
      m = self.method(action)
      m.call(payload["pullrequest_"+action]) unless m.nil?
    else
      "no method exists"
    end

  end

  def self.updated( payload )
    username = payload["author"]["display_name"]
    state = payload["state"]
    title = payload["title"]
    link = payload["source"]["repository"]["links"]["html"]["href"] + "/pull-requests"
    avatar = payload["source"]["repository"]["links"]["avatar"]["href"]

    parsed = {
      :bot_avatar_uri => avatar,
      :text => "#{username} updated Pull Request for <a href='#{link}'>[#{state}] #{title}</a>"
    }
    parsed
  end



end
