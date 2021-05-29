class SessionsController < ApplicationController
    before_action :require_no_user!, only: %i(create new)

    def new
        render :new
    end

    def create
        @user = User.find_by_credentials(
            params[:user][:user_name]
            params[:user][:password]
        )

        if @user
            login!(@user)
            redirect_to cats_url
        else
            flash.now[:errors] = ["Incorrect username and/or password"]
            render :new
        end
    end

    def destroy
        logout!
        redirect_to new_sessions_url
    end
end