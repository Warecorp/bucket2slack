class Parser
  @actions = [
    'created',
    'updated',
    'approve',
    'unapprove',
    'declined',
    'merged',
    'comment_created',
    'comment_updated',
    'comment_deleted',
  ]

  def self.process payload
    action = @actions.select { |act| payload.has_key? "pullrequest_"+act }.first
    is_method_exists = !action.nil? and self.respond_to? action

    if is_method_exists
      m = self.method action
      m.call payload["pullrequest_"+action] unless m.nil?
    else
      false
    end
  end

  def self.created data
    user = data["author"]["display_name"]
    id_pr = data["id"]
    title = data['title']
    reviewers = data['reviewers'].map { |x| x['display_name'] }.join ", "
    link = data['links']['html']['href']

    "#{user} created a new PR: \"<#{link}|##{id_pr}: #{title}>\". \nReviewers: #{reviewers}."
  end

  def self.updated data
    user = data["author"]["display_name"]
    state = data["state"]
    title = data["title"]
    link = data["source"]["repository"]["links"]["html"]["href"] + "/pull-requests"

    "#{user} updated a pull request for \"<#{link}|#{state} - #{title}>\"."
  end

  def self.approve data
    user = data["user"]["display_name"]
    "#{user} approved a pull request."
  end

  def self.unapprove data
    user = data["user"]["display_name"]
    "#{user} unapproved a pull request."
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

    "#{user}'s Pull Request \"#{title}\" has been successfully merged. :tada:"
  end

  def self.truncate excerpt
    max_length = 40
    excerpt.length > max_length ? excerpt[0..max_length] + "..." : excerpt
  end

  def self.comment_created data
    user = data["user"]["display_name"]
    link = data['links']['html']['href']
    excerpt = truncate data['content']['raw']

    "#{user} added a <#{link}|comment> on a pull request: \n'#{excerpt}'"
  end

  def self.comment_updated data
    user = data["user"]["display_name"]
    link = data['links']['html']['href']
    excerpt = truncate data['content']['raw']

    "#{user} updated the <#{link}|comment> on a pull request: \n'#{excerpt}'"
  end

  def self.comment_deleted data
    user = data["user"]["display_name"]
    link = data['links']['html']['href']

    "#{user} deleted a <#{link}|comment>"    
  end

end
