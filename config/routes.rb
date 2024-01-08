Rails.application.routes.draw do
  root to: 'static_pages#home'
  get '/property/:id' => 'static_pages#property'
  get '/login' => 'static_pages#login'
  get '/user_bookings' => 'static_pages#userBookings'

  namespace :api do
    # Add routes below this line
    resources :users, only: [:create]
    resources :sessions, only: %i[create destroy]
    resources :properties, only: [:index, :show]
    resources :bookings, only: [:create, :index]
    resources :charges, only: [:create]

    get '/properties/:id/bookings' => 'bookings#get_property_bookings'
    get '/authenticated' => 'sessions#authenticated'
    post '/charges/mark_complete' => 'charges#mark_complete'
    
  end

  namespace :api do
    resources :charges, only: [] do
      member do
        get 'success'
      end
    end
  end

end
