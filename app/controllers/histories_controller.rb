class HistoriesController < ApplicationController

    def index
        @histories = History.where(user: current_user.id)
    end

end