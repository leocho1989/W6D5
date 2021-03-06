class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    helper_method :current_user
    helper_method :logged_in?

    private

    def current_user
        return nil if !session[:session_token]
        @current_user||=User.find_by(session_token: session[:session_token])
    end

    def require_no_user!
        redirect_to cats_url if current_user
    end

    def logged_in?
        !current_user.nil?
    end

    def login_user!(user)
        session[:session_token] = user.reset_session_token!
    end

    def logout_user!
        current_user.reset_session_token!
        session[:session_token] = nil
    end

    def require_user!
        redirect_to new_sessions_url if current_user.nil?
    end

end
