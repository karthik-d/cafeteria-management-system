class UsersController < ApplicationController
    #skip_before_action :require_login

    def new
        # GET /users/new
        render "new"
    end

    def create
      # POST /users
      user = User.new(
        firstname: params[:firstname],
        lastname: params[:lastname],
        email: params[:email],
        mobile_num: params[:mobile],
        password: params[:password],
        role: "customer"
      )
      # Login user upon successful signup
      if (user.save)
        helpers.add_info_flash("Created your space. What are you craving?")
        session[:current_user_id] = user.id
        redirect_to root_path
      else
        helpers.add_error_flash(user.errors.full_messages)
        redirect_to new_user_path
      end
    end
end
