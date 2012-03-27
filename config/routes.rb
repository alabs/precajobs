Precajobs::Application.routes.draw do

  resources :votes

  #devise_for :users, 
  #  :path_names => { 
  #    :sign_in => 'login', 
  #    :sign_out => 'logout',
  #    :sign_up => 'signup' 
  #  },
  #  :controllers => { :registrations => "devise/registrations" }

  resources :offers do 
    post 'comment', :on => :member
    post 'vote', :on => :member
    get 'worst', :on => :collection
  end

  root :to => 'offers#index'

  match 'validator/url' => 'validator#url'

end
