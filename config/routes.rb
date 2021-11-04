Rails.application.routes.draw do

  root 'astro_objects#index'

  get 'about'=>'single_pages#about'
  get 'libraries'=>'single_pages#libraries'
  post 'libraries'=>'single_pages#addlibraries'
  delete 'libraries'=>'single_pages#dellibraries'

  resources :astro_objects do
    resources :chains
  end

  namespace :acts_as_taggable_on do
    resources :tags
  end

end
