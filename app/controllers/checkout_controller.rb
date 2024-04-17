class CheckoutController < ApplicationController
  before_action :authenticate_user!
  before_action :load_cart_items, only: [:show, :create_order]

  def show
    calculate_taxes
    calculate_total
  end

  def create_order
    calculate_total # Ensure calculate_total is called before building @order
    @order = current_user.orders.build(total_price: @total, order_date: Time.now)

    if @order.save
      create_order_items
      clear_cart_items
      redirect_to order_confirmation_path(@order), notice: 'Order was successfully created.'
    else
      puts @order.errors.full_messages # Add this line for debugging
      render :show
    end
  end

  def order_confirmation
    @order = Order.find(params[:id])
  end

  private

  def load_cart_items
    @cart_items = current_user.carts.includes(:product)
  end

  def calculate_taxes
    @province = current_user.province
    @subtotal = @cart_items.sum { |item| item.product.price * item.quantity }
    @pst = @subtotal * @province.pst_rate / 100
    @gst = @subtotal * @province.gst_rate / 100
    @hst = @subtotal * @province.hst_rate / 100
  end

  def calculate_total
    @province = current_user.province
    return unless @province # Exit early if province is nil

    @subtotal = @cart_items.sum { |item| item.product.price * item.quantity }
    @pst = @subtotal * @province.pst_rate / 100
    @gst = @subtotal * @province.gst_rate / 100
    @hst = @subtotal * @province.hst_rate / 100
    @total = @subtotal + @pst + @gst + @hst

    puts "Subtotal: #{@subtotal}"
    puts "PST: #{@pst}"
    puts "GST: #{@gst}"
    puts "HST: #{@hst}"
    puts "Total: #{@total}"
  end

  def create_order_items
    @cart_items.each do |cart_item|
      @order.order_items.create(product_id: cart_item.product_id, quantity: cart_item.quantity, price: cart_item.product.price)
    end
  end

  def clear_cart_items
    current_user.carts.destroy_all
  end

  def create_shipment
    @shipment = @order.build_shipment(
      shipment_date: Time.now,
      address: 'Your address here', # Modify this according to your requirements
      city: 'Your city here',
      state: 'Your state here',
      country: 'Your country here',
      zip_code: 'Your ZIP code here'
    )
    @shipment.save
  end
end
