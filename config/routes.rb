Rails.application.routes.draw do
  resources :holdprojects
  get 'student_login', to: 'sessions#new_student'
  get 'professor_login', to: 'sessions#new_professor'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#logout'

  get 'pages/home'
  resources :takings
  resources :groups
  resources :courses do 
    member do
      post 'create_groups'
    end
  end
  resources :professors
  resources :students do
    member do
      get 'add_course'
      post 'search_course'
    end
  end


  resources :professors do
    member do
      get 'add_course'
      post 'create_course'
    end
  end
  resources :preferences

  resources :groups do
    member do
      patch :move
    end 
  end 

  resources :holdprojects do
    member do
      patch :move

    end 
  end 


  root 'pages#home'
end
