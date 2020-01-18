Rails.application.routes.draw do
  root 'home#index'

  get 'twitter/home_timeline', to: 'twitter#home_timeline'

  namespace :oauth do
    get 'twitter/', to: 'twitter#authorize'
    get 'twitter/access_token', to: 'twitter#access_token'
  end
end
