Reservebar::Application.routes.prepend do
  match '', to: 'spree/digital_popups#index', constraints: lambda { |r| r.subdomain.present? && r.subdomain.include?('-digitalpopup') }
end

Spree::Core::Engine.routes.prepend do
  resources :digital_popups do
    get :engraving, on: :member
    get :products, on: :collection
  end
end
