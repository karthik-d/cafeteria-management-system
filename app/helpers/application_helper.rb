module ApplicationHelper
    def add_error_flash(msg)
        if flash[:error]
            flash[:error].append(msg)
        else
            flash[:error] = Array(msg)
        end
    end

    def add_info_flash(msg)
        if flash[:info]
            flash[:info].append(msg)
        else
            flash[:info] = Array(msg)
        end
    end
end
