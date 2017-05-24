class ReviewsController < ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy]
  def create
    @product = Product.find(params[:product_id])
    @review = @product.reviews.new(review_params)
    @review.user = current_user

    if @review.save
      redirect_to product_path(@product), notice: '评论发布成功。'
    else
      redirect_to product_path(@product), notice: '请输入您的评论。'
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to product_path(@product), alert: "成功删除评论内容。"
  end

  private
  def review_params
    params.require(:review).permit(:body)
  end
end
