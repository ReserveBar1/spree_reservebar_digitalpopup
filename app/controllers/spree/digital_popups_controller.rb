class Spree::DigitalPopupsController < Spree::BaseController
  layout 'digital_popup'
  before_filter :not_checkout
  before_filter :get_brand
  before_filter :chomp_params, only: [:index, :products]

  def index
    if @brand == 'remy'
      render 'remy/index'
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def products
    if @brand == 'remy'
      permalinks = [
        'remy-martin-vsop-1',
        'remy-martin-1738-accord-royal-custom-engraved-bottle',
        'remy-martin-xo-excellence-custom-engraved'
      ]
      @products = Spree::Product.where(permalink: permalinks).order(:id)
      render 'remy/products'
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def engraving
    if @brand == 'remy'
      @product = Spree::Variant.find_by_sku(params[:id]).product
      render 'remy/engraving'
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  private

  def not_checkout
    @not_checkout = true
  end

  def get_brand
    subdomain = request.subdomain
    @brand = subdomain.split('-')[0]
  end

  def chomp_params
    session.deep_merge!(params)
    guest_login if session[:user_email].present? and !current_user.present?
  end

  def guest_login
    user = Spree::User.anonymous!
    user.update_attribute(:email, session[:user_email])
    sign_in(:user, user)
  end

end
