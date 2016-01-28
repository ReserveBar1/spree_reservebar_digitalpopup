class Spree::DigitalPopupsController < Spree::BaseController
  require 'httparty'
  layout :determine_layout
  before_filter :not_checkout
  before_filter :get_brand
  before_filter :chomp_params, only: [:index, :products]

  def index
    if @brand == 'remy'
      render 'remy/index'
    elsif @brand == 'macallan'
      render 'macallan/index'
    elsif @brand == 'stoli'
      render 'stoli/index'
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
    elsif @brand == 'macallan'
      permalinks = [
        'the-macallan-fine-oak-10-years-old',
        'the-macallan-sherry-oak-12-years-old',
        'the-macallan-fine-oak-15-years-old',
        'the-macallan-fine-oak-17-years-old',
        'the-macallan-sherry-oak-18-years-old',
        'the-macallan-rare-cask'
      ]
      @products = Spree::Product.where(permalink: permalinks).order(:id)
      render 'macallan/products'
    elsif @brand == 'stoli'
      permalinks = [
        'elit-by-stolichnaya',
        'elit-by-stolichnaya-custom-engraved-bottle'
      ]
      @products = Spree::Product.where(permalink: permalinks).order(:id)
      render 'stoli/products'
    else
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def engraving
    if @brand == 'remy'
      @product = Spree::Variant.find_by_sku(params[:id]).product
      render 'remy/engraving'
    elsif @brand == 'stoli'
      @product = Spree::Variant.find_by_sku(params[:id]).product
      render 'stoli/engraving'
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
    session[:state_id] = Spree::State.find_by_abbr(session[:ship_state]).id if session[:ship_state].present?
    guest_login if session[:user_email].present? and !current_user.present?
    set_access_token
  end

  def guest_login
    user = Spree::User.anonymous!
    user.update_attribute(:email, session[:user_email])
    sign_in(:user, user)
  end

  def set_access_token
    if Rails.env == 'production'
      base_uri = 'https://engage360.co/api/oauth/token'
    else
      base_uri = 'https://beta.engage360.co/api/oauth/token'
    end
    options = {
      body: {
        grant_type: 'client_credentials',
        client_id: 'co.engage360.reserveBar',
        client_secret: 'H9lP30007IuG09050lLVgU23t'
      }
    }
    begin
      response = HTTParty.post(base_uri, options)
      session[:access_token] = response['access_token']
    rescue
      session[:access_token] = 'communication_err'
    end
  end

end
