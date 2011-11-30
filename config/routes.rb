Precajobs::Application.routes.draw do

  devise_for :users

  resources :offers do 
    post 'voting', :on => :member
    post 'comment', :on => :member
  end

  root :to => "offers#index"

end
