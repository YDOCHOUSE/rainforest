class ProductsController < ApplicationController
  

  def index
    if params[:search]           #if there is a search in the params hash
       @products = Product.all    # query that and split it and display it

      params[:search].split.each do |word|
        @products = @products.where("LOWER(name) LIKE LOWER(?)", "%#{word}%")
      end

      @products = @products.page(params[:page])  #if there isn't display products
    else                                          #via pagination
      @products = Product.order('products.created_at DESC').page(params[:page])
    end

    respond_to do |format|   
      format.html     # if format is html it looks for html.erb
      format.js       #this will pull from index.js.erb, this is what  
    end               #respond to does
  end

  def show
  	@product = Product.find(params[:id])

    if current_user
      @review = @product.reviews.build
    end
  end

  def new
  	@product = Product.new     # <---IN the new is it only Product.new without save because this is only the form page 
  end

  def edit
  	@product = Product.find(params[:id])   # <-- @product instance variable is essenitally a variable we're using to reference these database items and queries to reference in views? and other stuff we see fit.
  end

  def create
  	@product = Product.new(product_params)
  	if @product.save
  		redirect_to products_url
  	else
  		render :new
  	end
  end

  def update
  	@product = Product.find(params[:id])

  	if @product.update_attributes(product_params)
  		redirect_to product_path(@product)
  	else
  		render :edit
  	end
  end

  def destory
  	@product = product.find(params[:id])
  	@product.destroy 
  	redirect_to product_path
  end

  private
  def product_params
  	params.require(:product).permit(:name, :description, :price_in_cents)
  end
  	
end

