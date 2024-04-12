class CartsController < ApplicationController
  before_action :authenticate_user! # Ensure users are authenticated before accessing cart functionality

  def index
    @cart_items = current_user.carts.includes(:product)
  end

  def show
    @cart = current_user.cart
  end

  def create
    @product = Product.find(params[:product_id])
    @cart = current_user.carts.build(product: @product, quantity: 1) # Default quantity set to 1

    if @cart.save
      redirect_to @product, notice: 'Product added to cart successfully.'
    else
      flash[:alert] = @cart.errors.full_messages.join('. ')
      redirect_to @product
    end
  end

  def destroy
    @cart_item = current_user.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to carts_path, notice: 'Product removed from cart.'
  end
end
