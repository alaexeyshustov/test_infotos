Rails.application.routes.draw do
  root 'categories#index'

  get '/index',        to: 'categories#index', as: 'categories'
  get '/category/:id', to: 'categories#show',  as: 'category'
  get '/:id',          to: 'articles#show',    as: 'article'
end
