Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :cages
  resources :dinosaurs

  post 'cages/filter', to: 'cages#filter'
  post 'dinosaurs/filter_by_species', to: 'dinosaurs#filter_by_species'
  post 'dinosaurs/filter_by_cage', to: 'dinosaurs#filter_by_cage'
  put "dinosaurs/:id/move_to_cage", to: 'dinosaurs#move_to_cage'
end
