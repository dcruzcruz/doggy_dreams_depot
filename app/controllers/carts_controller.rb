class CartsController < ApplicationController
  before_action :authenticate_user! # Ensure users are authenticated before accessing cart functionality

  def index
    @cart_items = current_user.carts.includes(:product)
  end

  def show
    @cart_items = current_user.carts
  end

  def update
    @cart = Cart.find(params[:id])
    if @cart.update(cart_params)
      redirect_to @cart, notice: 'Cart was successfully updated.'
    else
      render :edit
    end
  end

  def cart_params
    params.require(:cart).permit(:quantity)
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
    @cart_item = current_user.carts.find_by(id: params[:id])

    if @cart_item
      @cart_item.destroy
      redirect_to root_path, notice: 'Product removed from cart.'
    else
      redirect_to root_path, alert: 'Product not found in cart.'
    end
  end
end
