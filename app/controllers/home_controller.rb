class HomeController < ApplicationController
    before_action :authenticate_user!, only: [ :index]  

    def index
       @product_categories = ProductCategory.all
       @company = Company.find_by(domain: current_user.domain)
       @ads = @company.ads
    end

    def search
        @company = Company.find_by(domain: current_user.domain)
        @ads = @company.ads.where("title LIKE :search OR description LIKE :search ", { search: "%#{params[:q]}%" })
        @product_categories = ProductCategory.all
        render :index
    end

    def filter
       @company = Company.find_by(domain: current_user.domain)  
       @ads = @company.ads.where(product_category_id: params[:product_category_id])
       @product_categories = ProductCategory.all
       render :index
    end
end