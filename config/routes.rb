Rails.application.routes.draw do
  devise_for :users,
    path: '',
    path_names: {
      sign_in: 'signin',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }

  resources :users
  resources :products
  resources :categories

end
