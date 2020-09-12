class HomeController < ApplicationController
    before_action :authenticate_user!, only: [ :index]  

    def index
       @product_categories = ProductCategory.all
       @ads = get_ads
    end

    def search
        @ads = get_ads.where("title LIKE :search OR 
                              description LIKE :search ",{ search: "%#{params[:q]}%"})
        @product_categories = ProductCategory.all
        render :index
    end

    def filter       
       @ads = get_ads.where(product_category_id: params[:product_category_id])
       @product_categories = ProductCategory.all
       render :index
    end

    def get_ads
        company = Company.find_by(domain: current_user.domain)  
        company.ads.available
    end


end