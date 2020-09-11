class SalesController < ApplicationController
    
    def show
        @sale = Sale.find(params[:id])
        @ad = @sale.ad
    end

    def create
        @ad = Ad.find(params[:ad_id])
        @sale = @ad.sales.build(buyer_id: current_user.id,status:'in_progress')
        @sale.save
        @ad.unavailable!
        History.create(user:current_user, sale:@sale, history_type:'purchase')
        History.create(user: @sale.ad.company_employee.user, sale:@sale, history_type:'sale')
        redirect_to ad_sale_path(@ad, @sale)
    end 
    
    def update
        @sale = Sale.find(params[:id])
        @ad = Ad.find(params[:ad_id])
        @sale.update(sale_params) 
         if @sale.finished? 
            @ad.unavailable!
         elsif @sale.canceled? 
            @ad.available! 
         end  
         render :show 
    end 

    private
    
    def sale_params
        params.require(:sale)
              .permit(:status,:final_price)             
    end

end