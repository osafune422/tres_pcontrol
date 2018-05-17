class ApplicationController < ActionController::Base
    before_action :set_current_user

    #idの引き継ぎ
    def set_current_user
        @current_user = User.find_by(id: session[:user_id])
    end
end
