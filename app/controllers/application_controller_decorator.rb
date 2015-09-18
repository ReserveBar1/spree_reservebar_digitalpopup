ApplicationController.class_eval do

  def determine_layout
    subdomain = request.subdomain
    if subdomain.present? && subdomain.include?('-digitalpopup')
      subdomain = request.subdomain
      @brand = subdomain.split('-')[0]
      'digital_popup'
    else
      '/spree/layouts/spree_application'
    end
  end

end
