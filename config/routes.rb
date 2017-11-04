Rails.application.routes.draw do
  resources :pages do
    resources :page_contents
  end
end
