module Oauth
  class TwitterController < ApplicationController
    TWITTER_API_KEY    = ENV['TWITTER_API_KEY']
    TWITTER_API_SECRET = ENV['TWITTER_API_SECRET']

    ACCESS_TOKEN        = ENV['TWITTER_ACCESS_TOKEN']
    ACCESS_TOKEN_SECRET = ENV['TWITTER_ACCESS_TOKEN_SECRET']

    TWITTER_CALLBACK = 'http://127.0.0.1:3000/oauth/twitter/access_token'

    def authorize
      request_token = oauth_client.get_request_token(oauth_callback: TWITTER_CALLBACK)

      session[:request_token] = request_token.token
      session[:request_token_secret] = request_token.secret

      redirect_to(request_token.authorize_url)
    end

    def access_token
      client = oauth_client

      request_token = OAuth::RequestToken.new(
        client,
        session[:request_token],
        session[:request_token_secret]
      )

      access_token = client.get_access_token(
        request_token,
        oauth_verifier: params[:oauth_verifier]
      )

      session[:access_token] = access_token.token
      session[:access_token_secret] = access_token.secret

      flash[:notice] = 'got access token'

      redirect_to('/')
    end

    private

    def oauth_client
      OAuth::Consumer.new(
        TWITTER_API_KEY,
        TWITTER_API_SECRET,
        site: 'https://api.twitter.com',
        schema: :header,
        method: :post,
        request_token_path: '/oauth/request_token',
        access_token_path: '/oauth/access_token',
        authorize_path: '/oauth/authorize'
      )
    end
  end
end
