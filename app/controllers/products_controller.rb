class ProductsController < ApplicationController
    def index
        @products = Product.all
    end

    def show
        @product = Product.find(params[:id])
    end

    def new
        if !helpers.super_user? 
            redirect_to login_path 
        else
            @product = Product.new
        end
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
        if !helpers.super_user? 
            redirect_to product_path
        else
            @product = Product.find(params[:id])
        end
    end
    
    def update
        @product = Product.find(params[:id])

        if @product.update(product_params)
            redirect_to product_path
        else
            render :edit, status: :unprocessable_entity
        end
    end
    
    def destroy
        if !helpers.super_user? 
            redirect_to product_path
        else
            @product = Product.find(params[:id])
            @product.destroy
        
            redirect_to products_path, status: :see_other
        end
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
end