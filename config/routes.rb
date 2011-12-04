Precajobs::Application.routes.draw do

  devise_for :users

  resources :offers do 
    post 'vote', :on => :member
  end

  root :to => 'offers#index'

  match 'validator/url' => 'validator#url'

end
