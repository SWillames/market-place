class SalesController < ApplicationController
    
    def show
        @sale = Sale.find(params[:id])
        @ad = @sale.ad
    end

    def create
        @ad = Ad.find(params[:ad_id])
        @sale = @ad.sales.build(buyer_id: current_user.id,
                               status:'waiting_seller')
        @sale.save
        redirect_to ad_sale_path(@ad, @sale)
    end 
    
    def update
      
        
    end 

    private
    
    def sale_params
        params.require(:sale)
              .permit(:status)             
    end

end