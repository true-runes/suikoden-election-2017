class ForMembersNormalVoteController < ApplicationController
  protect_from_forgery with: :null_session # HACK: よく勉強しないと危険
  include TweetsJoinUsers
  include SelectTweetsByHashtag
  include ForGetMethodAtMembers
  include ForPostMethodAtMembers
  layout 'application_members'
  before_action :site_http_basic_authenticate_with

  def site_http_basic_authenticate_with
    authenticate_or_request_with_http_basic("Hello, gensosenkyo staff!") do |username, password|
      username == Rails.application.secrets.members_page_auth_username && password == Rails.application.secrets.members_page_auth_password
    end
  end

  def index
    show_vote_result if request.get?
    show_vote_result_with_search(params[:search_word]) if request.post?
  end
end
