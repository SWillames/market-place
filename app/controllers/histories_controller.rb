class HistoriesController < ApplicationController
    before_action :authenticate_user!, only: [:index]

    def index
        @histories = History.where(user: current_user.id)
    end

end