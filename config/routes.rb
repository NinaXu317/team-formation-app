Rails.application.routes.draw do
  get 'student_login', to: 'sessions#new_student'
  get 'professor_login', to: 'sessions#new_professor'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#logout'
  resources :preferences
  get 'pages/home'
  resources :takings
  resources :groups
  resources :courses do 
    member do
      get 'create_groups'
    end
  end
  resources :professors
  resources :students do
    member do
      get 'add_course'
      post 'search_course'
    end
  end
  root 'pages#home'
end
