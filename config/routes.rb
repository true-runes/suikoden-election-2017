Rails.application.routes.draw do
  # HACK: below, not RESTful...
  get '/', to: 'index#index'
  resources :how_to_vote
  resources :tweet_as_vote
  resources :tweet_as_pr

  match '/for_members' => 'for_members#index', via: [ :get, :post ]
  resources :for_members

  match '/for_members_other_tag_vote' => 'for_members_other_tag_vote#index', via: [ :get, :post ]
  resources :for_members_other_tag_vote

  match '/for_members_duplicated_vote' => 'for_members_duplicated_vote#index', via: [ :get, :post ]
  resources :for_members_duplicated_vote

  match '/check_vote/result' => 'check_vote#result', via: [ :get, :post ]
  resources :check_vote
end
