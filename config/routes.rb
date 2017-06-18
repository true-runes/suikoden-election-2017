Rails.application.routes.draw do
  # HACK: below, not RESTful...
  get '/', to: 'index#index'
  resources :how_to_vote
  resources :tweet_as_vote
  resources :tweet_as_pr
  resources :for_members
  match '/check_vote/result' => 'check_vote#result', via: [ :get, :post ]
  resources :check_vote
end
