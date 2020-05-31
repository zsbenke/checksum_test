Rails.application.routes.draw do
  resource :checksum, only: [:new, :create]

  root to: 'checksums#new'
end
