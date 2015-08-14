ApplicationController.class_eval do

  def determine_layout
    subdomain = request.subdomain
    if subdomain.present? && subdomain.include?('-digitalpopup')
      'digital_popup'
    else
      '/spree/layouts/spree_application'
    end
  end

end
