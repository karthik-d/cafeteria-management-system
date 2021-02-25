class ApplicationController < ActionController::Base
  #before_action :require_login
  helper_method :current_user
  #before_action :require_access

  def require_access
    unless current_user && "#{controller_name.
                                camelize.
                                singularize}Policy".constantize.
                                new(current_user.role).
                                send("#{action_name}?")
        helpers.add_error_flash("Not authorized")
        redirect_to root_path
    end
  end

  def require_login
    unless current_user
        helpers.add_error_flash("Please login")
      redirect_to root_path
    end
  end

  def current_user
    # Return current user or nil if there's no session
    # Use memoization
    return @current_user if @current_user

    # If set, must be a valid user. Already authenticated before setting sessions hash
    if session[:current_user_id]
      @current_user = User.existing.find(session[:current_user_id])
    else
      return nil
    end
  end
end
