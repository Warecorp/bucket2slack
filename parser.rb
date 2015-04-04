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

    "#{user} updated a pull request for \"#{state} - #{title}\"; #{link}."
  end

  def self.approve data
    user = data["user"]["display_name"]
    "#{user} approved a pull request"
  end

  def self.unapprove data
    user = data["user"]["display_name"]
    "#{user} unapproved a pull request"
  end

  def self.declined data
    user = data["author"]["display_name"]
    title = data["title"]
    reason = data["reason"]

    "#{user} declined \"#{title}\"" + (!reason.nil? ? ", reason: '#{reason}'" : "")
  end

  def self.merged data
    user = data["author"]["display_name"]
    title = data["title"]

    "#{user}'s Pull Request \"#{title}\" has been successfully :tada:" 

  end

  def self.comment_created data
  end

  def self.comment_deleted data
  end

  def self.comment_updated data
  end
end
