Spree::Core::Engine.add_routes do
  devise_for :spree_user,
             class_name: Spree::User,
             only: [:omniauth_callbacks],
             controllers: { omniauth_callbacks: 'spree/omniauth_callbacks' },
             path: defined?(Spree::SocialConfig) ? Spree::SocialConfig[:path_prefix] : 'users'
  scope '(:locale)', locale: /#{Spree.available_locales.join('|')}/, defaults: { locale: nil } do
    resources :user_authentications

    get 'account' => 'users#show', as: 'user_root'

    namespace :admin do
      resources :authentication_methods
    end
  end
end
