Rails.application.routes.draw do
  get '/' => "users#index"

  post '/create' => "users#create"

  post '/addevent/:id' => 'users#addevent'

  get '/event/:id' => 'users#event'

  get '/events' => "users#events"

  get '/join/:id' => 'users#join'

  get '/unjoin/:id' => 'users#unjoin'

  get '/edit/:id' => 'users#edit'

  get '/eventedit/:id' => 'users#eventedit'

  post '/comment/:id' => 'users#comment'

  post '/update/:id' => 'users#update'

  post '/eventupdate/:id' => 'users#eventupdate'

  post '/login' => "users#login"

  get '/logout' => "users#logout"

  get '/users' => 'users#users'

  get '/user/:id' => 'users#info'

  get '/destroy/:id' => 'users#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
