Spree::TaxonsController.class_eval do
  def digital_popup
    subdomain = request.subdomain
    brand = subdomain.split('-')[0]

    if brand == 'remy'
      session.deep_merge!(params)

      # Logging in as Guest
      user = Spree::User.anonymous!
      user.update_attribute(:email, session[:user_email])
      sign_in(:user, user)

      @products = Spree::Brand.find_by_title('Remy Martin').products
      render 'remy_popup', layout: false
    # elsif brand == 'macallan'
    #   render 'macallan_popup', layout: false
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
