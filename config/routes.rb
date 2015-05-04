Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:show, :index]
  resources :friendships, only: [:create, :destroy, :accept] do
    member do 
      put :accept
    end
  end
  resources :posts do
  	member do
  		get "like", to: "posts#upvote"
  		get "dislike", to: "posts#downvote"
  	end
  	resources :comments
	end
  root 'posts#index'
  get 'tags/:tag', to: 'posts#index', as: :tag
end
