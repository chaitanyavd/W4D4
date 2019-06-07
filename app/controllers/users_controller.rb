class UsersController < ApplicationController

    before_action :require_no_user!, except: [:new, :create, :show]

    def new
        @user = User.new
        render :new
    end

    def show
        @user = User.find(params[:id])
        
        render :show
    end

    def create
        @user = User.new(user_params)
        if @user.save!
            log_in!(@user)
            redirect_to user_url(@user)
        else 
            render :new
        end 
    end

    private

    def user_params 
        params.require(:user).permit(:email, :password)
    end 
end
