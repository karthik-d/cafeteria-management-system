class HomeController < ApplicationController
    #skip_before_action :require_login

    def index
        render "index"
    end
end
