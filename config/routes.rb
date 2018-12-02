Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homes#index"
  devise_for :users, controllers: { sessions: 'users/sessions' }
  get 'users/find_friends' => "homes#find_friends", as: :find_friends

  get '/homes/share_with_friends' => 'homes#share_with_friends', as: :share_with_friends
  get '/homes/remove_my_friend' => 'homes#remove_my_friend', as: :remove_my_friend
  get '/homes/add_my_friend' => 'homes#add_my_friend', as: :add_my_friend
  get '/:username' => 'homes#my_public_share', as: :my_public_share
end
