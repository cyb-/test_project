Rails.application.routes.draw do
  devise_for :users, path:               "account",
                     skip:               [:invitations],
                     controllers:        { registrations: :registrations }
  devise_scope :user do
    get     "account/invitation/accept", to: "devise/invitations#edit",   as: :accept_user_invitation
    match   "account/invitation",        to: "devise/invitations#update", as: :user_invitation, via: [:patch, :put]
  end
end
