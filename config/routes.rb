Rails.application.routes.draw do
  # authentication APIs
  post 'auth/login', to: 'authentication#login'
  post 'auth/signup', to: 'authentication#signup'
  
  # post APIs
  post 'post', to: 'post#create_post'
end
