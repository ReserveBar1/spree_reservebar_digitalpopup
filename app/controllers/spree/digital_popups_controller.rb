module Spree
  class DigitalPopupsController < BaseController
    layout :determine_layout

    def index
      subdomain = request.subdomain
      brand = subdomain.split('-')[0]

      if brand == 'remy'
        session.deep_merge!(params)

        # Logging in as Guest
        user = Spree::User.anonymous!
        user.update_attribute(:email, session[:user_email])
        sign_in(:user, user)

        @products = Spree::Brand.find_by_title('Remy Martin').products
        render 'remy_popup'
      else
        raise ActionController::RoutingError.new('Not Found')
      end
    end

  end
end
