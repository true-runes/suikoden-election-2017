Rails.application.routes.draw do
  # HACK: below, not RESTful...
  get '/', to: 'index#index'
  resources :how_to_vote
  resources :tweet_as_vote
  resources :tweet_as_pr
  resources :for_members
  resources :for_members_other_tag_vote
  resources :for_members_duplicated_vote
  match '/check_vote/result' => 'check_vote#result', via: [ :get, :post ]
  resources :check_vote
end
