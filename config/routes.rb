Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check
  # resources :web_crawler

  root 'web_crawler#index'
  post 'crawl_any_website', to: 'web_crawler#crawl_any_website'
  get  'show_sitemap',     to: 'web_crawler#show_sitemap'

  # Defines the root path route ("/")
  # root "posts#index"
end
