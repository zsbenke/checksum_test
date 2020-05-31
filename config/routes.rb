Rails.application.routes.draw do
  resource :checksum, only: [:new, :create]
end
