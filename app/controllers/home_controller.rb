class HomeController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(6)
    @categories = Category.all
  end
end
