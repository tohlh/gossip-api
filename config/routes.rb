Rails.application.routes.draw do
  # authentication APIs
  post 'auth/login', to: 'authentication#login'
  post 'auth/signup', to: 'authentication#signup'

  # account APIs
  patch 'account/details', to: 'account#update_details'
  patch 'account/password', to: 'account#update_password'
  delete 'account/delete', to: 'account#delete_account'

  # user
  get 'user/current', to: 'user#get_current_user'
  get 'user', to: 'user#get_user_profile'
  get 'user/posts', to: 'user#get_user_posts'
  
  # post APIs
  get 'posts', to: 'post#get_posts'
  get 'post', to: 'post#get_post'
  post 'post', to: 'post#create_post'
  patch 'post', to: 'post#update_post'
  delete 'post', to: 'post#delete_post'

  # tag
  get 'tags', to: 'tag#get_tags'

  # comments APIs
  get 'comments', to: 'comment#get_comments'
  post 'comment', to: 'comment#create_comment'
  patch 'comment', to: 'comment#update_comment'
  delete 'comment', to: 'comment#delete_comment'
end
