class ApplicationController < ActionController::Base
    before_action :initialize_session
    
    def clearsession
        session[:user] = nil
        session[:cart] = nil
    end

private
    def initialize_session
        empty_cart = Product.all.map{|p| [p.id, 0]}.to_h # maps product id and count in session
        session[:cart] ||= empty_cart # creates an empty cart if one does not exist
        session[:user] ||= nil # creates an empty user if one does not exist
        @item_count = session[:cart].values.reduce(:+) # number of products in cart
    end
end
