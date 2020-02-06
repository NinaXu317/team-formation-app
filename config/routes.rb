Rails.application.routes.draw do
  resources :takings
  resources :groups
  resources :courses
  resources :professors
  resources :students
  root 'application#hello'
end
