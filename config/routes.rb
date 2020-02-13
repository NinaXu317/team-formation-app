Rails.application.routes.draw do
  get 'pages/home'
  resources :takings
  resources :groups
  resources :courses
  resources :professors
  resources :students
  root 'pages#home'
end
