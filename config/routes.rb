Rails.application.routes.draw do
  get '/employees/' => 'employees#index'
  get '/employees/new' => 'employees#new'
  post '/employees' => 'employees#create'
  get '/employees/:id' => 'employees#show'
  get '/employees/:id/edit' => 'employees#edit'
  patch '/employees/:id' => 'employees#update'
  delete '/employees/:id' => 'employees#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
