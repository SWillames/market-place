class HomeController < ApplicationController
    before_action :authenticate_user!, only: [ :index]  

    def index
       @company = Company.find_by(domain: current_user.domain)
       @ads = @company.ads
    end
end