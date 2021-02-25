class AdminsController < ApplicationController
    # Controller for Admin User Management

    def index
        render "index"
    end

    def new
        render "new"
    end

    def show
      user = User.non_customers.find_by(id: params[:id])
      if(user)
        @user = user
        render "show"
      else
        redirect_to list_users_path
      end
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
            role: params[:role]
        )
        if(!user.save)
            helpers.add_error_flash(user.errors.full_messages)
            redirect_to new_employee_path
        else
            helpers.add_info_flash("Login credentials created for new employee")
            redirect_to list_users_path
        end
    end

    def update
      # PUT /users/:id as Owner
      # Only for billing clerks
      user = User.non_customers.find_by(id: params[:id])
      if(user)
        user.firstname = params[:firstname]
        user.lastname = params[:lastname]
        user.email = params[:email]
        user.mobile_num = params[:mobile]
        user.role = params[:role]
        if(!params[:password].empty?)
          user.password = params[:password]
        end

        if(!user.save)
          helpers.add_error_flash(user.errors.full_messages)
          redirect_to edit_employee_path
        else
          helpers.add_info_flash("Employee details updated")
          redirect_to list_users_path
        end
      else
        redirect_to list_users_path
      end
    end

    def destroy
      # DELETE /users/:id as Owner
      user = User.non_customers.find_by(id: params[:id])
      if(user)
        user.archived_at = Time.now
        user.save
        helpers.add_info_flash("Employee '#{user.name}' deleted")
      end
      redirect_to list_users_path
    end
end
