class AdsController < ApplicationController
  before_action :authenticate_user!, only: [:show,:new, :create]  

   def show
    @ad = Ad.find(params[:id])
   end
   
   def new
      if current_user.company_employee.nil?
        redirect_to new_company_employee_path, notice: 'Complete seu cadastro para anunciar'
      else
        @ad = Ad.new
        @product_categories = ProductCategory.all
      end
    end

   def create
    @ad = Ad.new(ad_params)
    @ad.save
    redirect_to ad_path(@ad)    
   end

   private 

    def ad_params
      params.require(:ad)
            .permit(:title, :description, :price, :status, :product_category_id, images: [])
            .merge(company_employee_id: current_user.company_employee_id)
    end

end