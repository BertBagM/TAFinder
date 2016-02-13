class AdminController < ApplicationController
    before_action :require_admin


    def require_admin
        # TODO: validate admin user here
    end
end