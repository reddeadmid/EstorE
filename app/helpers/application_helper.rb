module ApplicationHelper
    def logged_in?
        !!session[:user]
    end
    def current_user
        @current_user ||= User.find_by_id(session[:user]) if !!session[:user]
    end
end
