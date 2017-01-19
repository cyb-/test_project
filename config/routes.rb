Rails.application.routes.draw do
  root      "main#index"

  resources :users do
    member do
      get   :edit_role,                  constraints: { format: :js }
      match :update_role,                via: [:patch, :put]
    end
  end

  devise_for :users, path:               "account",
                     skip:               [:invitations],
                     controllers:        { registrations: :registrations }
  devise_scope :user do
    get     "account/invitation/accept", to: "devise/invitations#edit",   as: :accept_user_invitation
    match   "account/invitation",        to: "devise/invitations#update", as: :user_invitation, via: [:patch, :put]
  end
end
