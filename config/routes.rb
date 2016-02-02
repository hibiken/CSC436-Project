Rails.application.routes.draw do
  namespace :api, defaults: { format: :json },
                  constraints: { subdomain: 'api' }, path: '/' do
    # resources go here
  end
end
