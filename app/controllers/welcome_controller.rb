class WelcomeController < ApplicationController
  def index
  end

  def index01
    @products = Product.onshelf.page(params[:page] || 1).per_page(params[:per_page] || 16)
                .order("id desc").includes(:main_product_image)
  end
end
