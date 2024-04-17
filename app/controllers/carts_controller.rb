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
    @cart = current_user.carts.find_or_initialize_by(product_id: @product.id)

    if @cart.persisted?
      # If the cart item already exists, update its quantity
      @cart.quantity += 1
    else
      # If the cart item is new, set its quantity to 1
      @cart.quantity = 1
    end

    if @cart.save
      redirect_to @product, notice: 'Product added to cart successfully.'
    else
      flash[:alert] = @cart.errors.full_messages.join('. ')
      redirect_to @product
    end
  end

  def destroy
    @cart_item = Cart.find(params[:id])
    @cart_item.destroy
    redirect_to carts_path, notice: 'Item removed from cart successfully.'
  end

  def increase_quantity
    @cart_item = current_user.carts.find(params[:id])
    @cart_item.quantity += 1
    @cart_item.save
    redirect_to carts_path, notice: 'Quantity increased successfully.'
  end

  def decrease_quantity
    @cart_item = current_user.carts.find(params[:id])
    @cart_item.quantity -= 1 if @cart_item.quantity > 1
    @cart_item.save
    redirect_to carts_path, notice: 'Quantity decreased successfully.'
  end

end
