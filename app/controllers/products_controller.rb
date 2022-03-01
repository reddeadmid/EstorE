class ProductsController < ApplicationController
    before_action :initialize_cart

    def index
        @products = Product.all
    end
    def show
        @product = Product.find(params[:id])
    end

    def new
        @product = Product.new
    end

    def create
        @product = Product.new(product_params)

        if @product.save
            redirect_to @product
        else
            render :new, status: :unprocessable_entity
        end
    end
    
    def edit
        @product = Product.find(params[:id])
    end
    
    def update
        @product = Product.find(params[:id])

        if @product.update(product_params)
            redirect_to @product
        else
            render :edit, status: :unprocessable_entity
        end
    end
    
    def destroy
        @product = Product.find(params[:id])
        @product.destroy
    
        redirect_to product_path, status: :see_other
    end

    def cart
        @cart = session[:cart]
            .filter{|id,count| count>0} # only takes products with > zero counts
            .map{|id,count| [Product.find(id),count]} # associates session to dbase
    end

    def checkout
        session[:cart] = nil # empties cart after perchases
        redirect_to products_path
    end
    
    def buy
        @product = Product.find(params[:id])
        session[:cart][@product.id.to_s]+=1
        redirect_to product_path
    end
    
private
    def product_params
        params.require(:product).permit(:name, :description, :stock, :price, :status, :image)
    end

    def initialize_cart
        empty_cart = Product.all.map{|p| [p.id, 0]}.to_h # maps product id and count in session
        session[:cart] ||= empty_cart # creates an empty cart if one does not exist
        @item_count = session[:cart].values.reduce(:+) # number of products in cart
    end
end