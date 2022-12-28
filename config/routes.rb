Rails.application.routes.draw do
  # authentication APIs
  post 'auth/login', to: 'authentication#login'
  post 'auth/signup', to: 'authentication#signup'
  
  # post APIs
  get 'posts', to: 'post#get_posts'
  get 'post', to: 'post#get_post'
  post 'post', to: 'post#create_post'
  patch 'post', to: 'post#update_post'
  delete 'post', to: 'post#delete_post'

  # comments APIs
  get 'comments', to: 'comment#get_comments'
  post 'comment', to: 'comment#create_comment'
  patch 'comment', to: 'comment#update_comment'
  delete 'comment', to: 'comment#delete_comment'
end
