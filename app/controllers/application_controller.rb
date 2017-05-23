class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :fetch_home_data #这个没有必要再这里写。后期优化
  before_action :set_browser_uuid

  def admin_required
   if !current_user.admin?
     redirect_to "/", alert: "You are not admin."
   end
  end

  helper_method :current_cart

  def current_cart
    @current_cart ||= find_cart
  end

  def fetch_home_data
    @categories = Category.grouped_data
  end

  def set_browser_uuid
    uuid = cookies[:user_uuid]

    unless uuid
      if logged_in?
        uuid = current_user.uuid
      else
        uuid = RandomCode.generate_utoken
      end
    end

    update_browser_uuid uuid
  end

  def update_browser_uuid uuid
    session[:user_uuid] = cookies.permanent['user_uuid'] = uuid
  end

  private

  def find_cart
    cart = Cart.find_by(id: session[:cart_id])
    if cart.blank?
      cart = Cart.create
    end
    session[:cart_id] = cart.id
    return cart
  end
end
