Rails.application.routes.draw do 
  devise_for :users

  root "home#index"
  get "home/index"

  get "search_words", to: "words#search", as: :search_words

  resources :word_books do
    resources :words, except: [:index] do
      collection do
        get :search
      end
    end
  end

  resources :exams

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

end
