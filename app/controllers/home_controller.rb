class HomeController < ApplicationController
  def index
    @products = Product.all
  end
  def list
    @products = Product.all
  end
end