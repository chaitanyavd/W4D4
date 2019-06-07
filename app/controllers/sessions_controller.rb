class SessionsController < ApplicationController

    before_action :require_no_user!

    def new
        render :new
    end

    def create
        @user = User.find_by_credentials(
            params[:user][:email],
            params[:user][:password] )
        if @user 
            log_in!(@user)
            redirect_to user_url(@user.id)
        else 
            render :new
        end
    end 

    def destroy 
        logout!
        redirect_to new_user
    end 

end
