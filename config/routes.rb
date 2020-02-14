Rails.application.routes.draw do
  get 'pages/home'
  
  #get  '/courses/1/create_groups',  to: 'courses#create_groups'
  resources :takings
  resources :groups
  resources :courses do 
    member do
      get 'create_groups'
    end
  end
  resources :professors
  resources :students
  root 'pages#home'
end
