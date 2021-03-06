class ReviewsController < ApplicationController
  before_filter :load_product, :ensure_logged_in, only: [:create, :destroy]

  def show
    @review = Review.find(params[:id])
  end


# Check out this article on [.build](http://stackoverflow.com/questions/783584/ruby-on-rails-how-do-i-use-the-active-record-build-method-in-a-belongs-to-rel)
    # You could use a longer alternate syntax if it makes more sense to you
    # 
    # @review = Review.new(
    #   comment: params[:review][:comment],
    #   product_id: @product.id,
    #   user_id: current_user.id
    # )

  def create
  	@review = @product.reviews.build(review_params)
  	@review.user = current_user

      if @review.save
        respond_to do |format|
        format.html { redirect_to product_path(@product.id), notice: 'Review added!'}
        format.js {}
      end
      else
        format.html { render 'products/show', alert: "There was an error, please try again" }
        format.js

    end
  end

  def destroy
  	@review = Review.find(params[:id])
  	@review.destroy
  end


private

def review_params
	params.require(:review).permit(:comment, :product_id)	
end

def load_product
	@product = Product.find(params[:product_id])
end


end