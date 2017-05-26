class ProductsController < ApplicationController

  before_action :authenticate_user!, only: [:favorite, :unfavorite]
  
  def index
    fetch_home_data
    @products = Product.onshelf.page(params[:page] || 1).per_page(params[:per_page] || 12)
                .order("id desc").includes(:main_product_image)
  end

  def show
   fetch_home_data
   @product = Product.find(params[:id])
  end

  def add_to_cart
    @product = Product.find(params[:id])
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] = "你已成功将 #{@product.title} 加入购物车"
    else
      flash[:warning] = "你的购物车内已有此物品"
    end
    redirect_to :back
  end

  def upvote
    @product = Product.find(params[:id])
    @product.upvote_by current_user
    redirect_to :back
  end

  def favorite
		@product = Product.find(params[:id])
		current_user.favorite_products << @product
    flash[:notice] = "您已收藏宝贝"
		redirect_to :back
	end

	def unfavorite
		@product = Product.find(params[:id])
		current_user.favorite_products.delete(@product)
    flash[:notice] = "您已取消收藏宝贝"
		redirect_to :back
	end

end
