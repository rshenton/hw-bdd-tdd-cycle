Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  
  get '/find_same_director/:id', to: 'movies#find_same_director', as: :same_director
end
