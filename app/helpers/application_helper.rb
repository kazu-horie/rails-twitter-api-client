module ApplicationHelper
  def authorized?
    session[:access_token] && session[:access_token_secret]
  end
end
