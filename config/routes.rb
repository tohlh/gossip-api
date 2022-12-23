Rails.application.routes.draw do
  # authentication APIs
  post 'auth/login', to: 'authentication#login'
  post 'auth/signup', to: 'authentication#signup'
  
  # post APIs
  get 'posts', to: 'post#get_posts'
  get 'post', to: 'post#get_post'
  post 'post', to: 'post#create_post'
  delete 'post', to: 'post#delete_post'
end
