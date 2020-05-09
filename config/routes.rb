Rails.application.routes.draw do

  get 'pages/home'

  get 'student_login', to: 'sessions#new_student'
  get 'professor_login', to: 'sessions#new_professor'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#logout'

  resources :holdprojects

  resources :takings

  resources :courses do 
    member do
      post 'create_groups'
      patch 'toggle_voting'
    end
  end
  
  resources :professors

  resources :students do
    member do
      get 'add_course'
      post 'search_course'
      delete 'drop_course'
    end
  end


  resources :professors do
    member do
      get 'add_course'
      post 'create_course'
    end
  end

  resources :account_activations, only: [:edit]

  resources :preferences 

  resources :groups do
    member do
      patch :move
      patch :vote
    end 
  end 


  root 'pages#home'
end
