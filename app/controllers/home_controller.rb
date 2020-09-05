class HomeController < ApplicationController
    def index
       @company = Company.find_by(domain: current_user.domain)
       @ads = @company.ads
    end
end