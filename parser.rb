require 'logger'

class Parser
  @actions = [
    "updated",
    "updatd",
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
    link = payload[""]
    "#{username} updated \"[#{state}] #{title}\". Link: "
  end

  def self.updatd( payload )
    "~~~~"
  end

end
