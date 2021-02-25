class RoleRoutingConstraint

    def initialize(role)
        @check_role = role
    end

    def current_user(request)
        # Return current user or nil if there's no session
        # Use memoization
        return @current_user if @current_user

        # If set, must be a valid user. Already authenticated before setting sessions hash
        if request.session[:current_user_id]
            @current_user = User.existing.find(request.session[:current_user_id])
        else
            return nil
        end
    end

    def matches?(request)
        user = current_user(request)
        puts user.role
        user && user.check_role(@check_role)
    end
end
