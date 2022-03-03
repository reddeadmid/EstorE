module ApplicationHelper
    def logged_in?
        !!session[:user]
    end

    def current_user
        @current_user ||= User.find_by_id(session[:user]) if !!session[:user]
    end
    
    def super_user?
        session[:user].to_s == "1" || session[:user].to_s == "2"
    end

    def user_match?
        session[:user].to_s == params[:id].to_s
    end
end
