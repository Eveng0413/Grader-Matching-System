Rails.application.routes.draw do
  resources :sections
  #resources :courses

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    unlocks: 'users/unlocks'
  }

  authenticated :user do
    root 'courses#index', as: :authenticated_root
  end

  devise_scope :user do
    unauthenticated :user do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  # authenticated :user do
  #   root 'placeholder#welcome', as: :authenticated_root
  # end

  devise_scope :user do
    root to: "devise/sessions#new"
  end

  # lab3 part
  # get 'student_information', to: 'students#information', as: 'student_information'

  # lab3 part
  # resources :students do
  #   collection do
  #     # post 'setgpa' 
  #     post 'settime'
  #  end
  # end 


  # # Defines the root path route ("/")
  # root "courses#index"


  resources :courses, only: [:index]
  
   # Reset database route
  post '/reset_courses', to: 'courses#reset'

  # Edit course route
  get 'courses/edit', to: 'courses#edit'

  # New course route
  get 'courses/new', to: 'courses#new'

  #Redirect show page to course index
  get 'courses/:id', to: 'courses#index'

  get 'courses/:id/sections/:id', to: 'courses#index'

  # courses/course_id/section/:id route
  resources :courses do
    resources :sections
  end


  # config/routes.rb
  resources :role_requests do
    member do
      put 'approve'
      put 'deny'
    end
  end

end

