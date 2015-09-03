class Spree::DigitalPopupsController < Spree::BaseController
  layout 'digital_popup'
  before_filter :get_brand

  def index
    session.deep_merge!(params)
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
      @products = Spree::Product.where(permalink: permalinks)
      render 'remy/products'
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  private

  def get_brand
    subdomain = request.subdomain
    @brand = subdomain.split('-')[0]
  end

end
