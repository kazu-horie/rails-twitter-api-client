Rails.application.routes.draw do
  root 'home#index'

  namespace :oauth do
    get 'twitter/', to: 'twitter#authorize'
    get 'twitter/access_token', to: 'twitter#access_token'
  end
end
