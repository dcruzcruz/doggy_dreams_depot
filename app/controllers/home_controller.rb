class HomeController < ApplicationController
  def index
    @products = Product.page(params[:page]).per(6)
    @categories = Category.all
    @new_products = Product.where("created_at >= ?", 2.days.ago)
                           .order(created_at: :desc)
                           .limit(6)
    @recently_updated_products = Product.where("created_at < ?", 2.days.ago)
                                        .where("updated_at >= ?", 2.days.ago)
                                        .where("stock < ?", 6)
                                        .order(updated_at: :desc)
                                        .limit(5)
  end
end
