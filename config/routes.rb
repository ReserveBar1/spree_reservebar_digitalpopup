Reservebar::Application.routes.prepend do

  match '', to: 'spree/taxons#digital_popup', constraints: lambda { |r| r.subdomain.present? && r.subdomain.include?('-digitalpopup') }

end
