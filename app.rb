require 'sinatra'
require 'json'
require 'logger'
require 'mail'

require_relative 'parser'

options = {
  :address => "smtp.gmail.com",
  :port => 587,
  :user_name => ENV['username'] || 'xxx',
  :password => ENV['password'] || 'xxx',
  :authentication => 'plain',
  :enable_starttls_auto => true
}

Mail.defaults do
  delivery_method :smtp, options
end

get '/' do
  "Post to this URL"
end

post '/' do
  content_type :json

  payload = JSON.parse request.body.read

  # Parser.process(payload)
  Mail.deliver do
    from 'ikhsan.assaat@gmail.com'
    to 'ikhsan.assaat@gmail.com'
    subject 'test'
    body payload.to_s
  end

end
