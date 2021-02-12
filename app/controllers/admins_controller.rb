class AdminsController < ApplicationController
    # Controller for Admin User Management

    def index
        render "index"
    end

    def new
        render "new"
    end

    def create
        # POST /users as Owner
        # Creates new billing clerk
        user = User.new(
            firstname: params[:firstname],
            lastname: params[:lastname],
            email: params[:email],
            mobile_num: params[:mobile],
            password: params[:password],
            role: "billing_clerk"
        )
        if(!user.save)
            helpers.add_error_flash(user.errors.full_messages)
            redirect_to new_employee_path
        else
            helpers.add_info_flash("Login credentials created for new employee")
            redirect_to list_users_path
        end
    end
end
