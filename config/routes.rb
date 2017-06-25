Rails.application.routes.draw do
  # HACK: below, not RESTful...
  get '/', to: 'index#index'
  resources :how_to_vote
  resources :tweet_as_vote
  resources :tweet_as_pr

  match '/for_members/requirement' => 'for_members#requirement', via: [ :get, :post ]
  resources :for_members

  match '/for_members_normal_vote' => 'for_members_normal_vote#index', via: [ :get, :post ]
  resources :for_members_normal_vote

  match '/for_members_other_tag_vote' => 'for_members_other_tag_vote#index', via: [ :get, :post ]
  resources :for_members_other_tag_vote

  match '/for_members_duplicated_vote' => 'for_members_duplicated_vote#index', via: [ :get, :post ]
  resources :for_members_duplicated_vote

  match '/for_members_all_vote' => 'for_members_all_vote#index', via: [ :get, :post ]
  match '/for_members_all_vote/result' => 'for_members_check_vote#result', via: [ :get, :post ]
  resources :for_members_all_vote

  match '/check_vote/result' => 'check_vote#result', via: [ :get, :post ]
  resources :check_vote

  match '/for_members_check_vote/result' => 'for_members_check_vote#result', via: [ :get, :post ]
  resources :for_members_check_vote

  match '/count_vote' => 'count_vote#index', via: [ :get, :post ]
  resources :count_vote
end
