Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
  get '/users/sign_out' => 'devise/sessions#destroy'
end
  resources :books do
    member do
      delete :destroy
    end
    resources :reviews   #reivews resource are nested inside the books
  end
  root 'books#index'                # home#index
end
