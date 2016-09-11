Rails.application.routes.draw do
  namespace :api, defaults: { format: "json" } do
    get 'posts/:id' => 'posts#show', as: :post_show
    post 'posts' => 'posts#create', as: :post_create
    put 'posts/:id' => 'posts#update', as: :post_update
    delete 'posts/:id' => 'posts#destroy', as: :post_delete
    get 'posts' => 'posts#index', as: :posts_index

    get 'users' => "users#index"
    get 'users/:id' => "users#show"
    post 'signup' => "users#create"

    post 'login' => "session#authenticate"
  end
end
