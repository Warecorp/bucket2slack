class Parser
  @actions = [
    'created',
    'updated',
    'approve',
    'unapprove',
    'declined',
    'merged',
    'comment_created',
    'comment_deleted',
    'comment_updated'
  ]

  def self.process payload
    action = @actions.select { |act| payload.has_key? "pullrequest_"+act }.first
    is_method_exists = !action.nil? and self.respond_to? action

    if is_method_exists
      m = self.method action
      m.call payload["pullrequest_"+action] unless m.nil?
    else
      "No method exists"
    end
  end

  def self.created data
  end

  def self.updated data
    user = data["author"]["display_name"]
    state = data["state"]
    title = data["title"]
    link = data["source"]["repository"]["links"]["html"]["href"] + "/pull-requests"
    avatar = data["source"]["repository"]["links"]["avatar"]["href"]

    "#{user} updated Pull Request for \"#{state} - #{title}\"; #{link}"
  end

  def self.approve data
    user = data["user"]["display_name"]
    "#{user} approved a pull request"
  end

  def self.unapprove data
  end

  def self.declined data
  end

  def self.comment_created data
  end

  def self.comment_deleted data
  end

  def self.comment_updated data
  end
end
