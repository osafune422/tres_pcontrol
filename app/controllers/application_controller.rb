class ApplicationController < ActionController::Base
    protect_from_forgery
  
    before_action :set_current_user

    #idの引き継ぎ
    def set_current_user
        @current_user = User.find_by(id: session[:user_id])
    end
  
    #未登録者のアクセス制限
    def authenticate_user
        if @current_user == nil
            flash[:notice]="ログインが必要です"
            redirect_to("/login")
        end
    end
  
    #登録者のアクセス制限
    def forbid_login_user
        if @current_user
            flash[:notice]="すでにログインしています"
            redirect_to("/mypage")
        end
    end
    
end
