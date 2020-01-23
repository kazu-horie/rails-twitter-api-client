class TwitterController < ApplicationController
  TWITTER_API_KEY    = ENV['TWITTER_API_KEY']
  TWITTER_API_SECRET = ENV['TWITTER_API_SECRET']

  def home_timeline
    consumer = OAuth::Consumer.new(
      TWITTER_API_KEY,
      TWITTER_API_SECRET,
      site: 'https://api.twitter.com/'
    )

    endpoint = OAuth::AccessToken.new(
      consumer,
      session[:access_token],
      session[:access_token_secret]
    )

    response = endpoint.get('https://api.twitter.com/1.1/statuses/home_timeline.json')

    @tweets = JSON.parse(response.body)
  end
end
