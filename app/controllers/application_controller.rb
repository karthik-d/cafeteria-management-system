class ApplicationController < ActionController::Base
    #before_action :require_login
    helper_method :current_user

    def require_login
        unless current_user
            redirect_to root_path
        end
    end

    def current_user
        # Return current user or nil if there's no session
        # Use memoization
        return @current_user if @current_user

        # If set, must be a valid user. Already authenticated before setting sessions hash
        if session[:current_user_id]
            @current_user = User.find(session[:current_user_id])
        else
            return nil
        end
    end
end
