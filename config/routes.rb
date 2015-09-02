Reservebar::Application.routes.prepend do

  match '', to: 'spree/digital_popups#index', constraints: lambda { |r| r.subdomain.present? && r.subdomain.include?('-digitalpopup') }

end
