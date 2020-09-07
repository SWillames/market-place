class SalesController < ApplicationController
    
    def show
        @sale = Sale.find(params[:id])
        @ad = @sale.ad
    end

    def create
        @ad = Ad.find(params[:ad_id])
        @sale = @ad.build_sale(buyer_id: current_user.company_employee.id,
                               status:'started')
        @sale.save
        render :show
    end 
    
    def update
        
    end 

    private
    
    def sale_params
        params.require(:sale)
              .permit(:status)             
    end

end