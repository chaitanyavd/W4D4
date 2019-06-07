class ApplicationController < ActionController::Base

 skip_before_action :verify_authenticity_token


    helper_method :current_user 
    helper_method :logged_in? 

    def require_no_user!
        redirect_to new_user_url if current_user
    end

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def logged_in?
        !!current_user
    end 

    def log_in!(user)
        session[:session_token] = user.reset_session_token!
    end

    def logout!
        current_user.reset_session_token! if current_user # a placeholder for the sercer 
        session[:session_token] = nil 
        @current_user = nil 
    end 


end
