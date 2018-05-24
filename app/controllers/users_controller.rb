class UsersController < ApplicationController
  require 'date'
  before_action :authenticate_user, {only:[:mypage, :edit, :new]}       #ログインなしの時
  before_action :forbid_login_user, {only:[:login_form, :login]}       #ログインありの時
  before_action :ensure_correct_user, {only:[:new, :create, :index, :show, :destroy, :edit_depa, :update_depa]}      #管理者でないログインの時
  
  def mypage
    @user = User.find_by(id: @current_user.id)
    @attends = @user.attends.order("date DESC")
#    @attends = @attends.where(start: now.beginning_of_month..now.end_of_month)
  end
  
  def clockon
    if Attend.find_by(user_id: @current_user.id, date: Date.today)
      @attend = Attend.find_by(user_id: @current_user.id, date: Date.today)
      @attend.start = Time.now
    else
      @attend=Attend.new(
        user_id: @current_user.id,
        date: Date.today,
        start: Time.now
        )
    end
      
    if @attend.save
      flash[:notice] = "出勤登録が完了しました"
      redirect_to("/mypage")
    else
      render("users/mypage")
    end
  end
  
  def clockout
    if Attend.find_by(user_id: @current_user.id, date: Date.today)
      @attend = Attend.find_by(user_id: @current_user.id, date: Date.today)
      @attend.finish = Time.now
      @attend.sum = @attend.finish - @attend.start - @attend.rest
    else
      @attend=Attend.new(
        user_id: @current_user.id,
        date: Date.today,
        finish: Time.now
        )
    end
    
    if @attend.save
      flash[:notice] = "出勤登録が完了しました"
      redirect_to("/mypage")
    else
      render("users/mypage")
    end
  end
  
  def remark
    if Attend.find_by(user_id: @current_user.id, date: params[:date])
      @attend = Attend.find_by(user_id: @current_user.id, date: params[:date])
      @attend.remark = params[:remark]
      
      if params[:remark] == "有給(1日)"
        @attend.user.paidholi_sum -= 1
      elsif params[:remark] == "有給(半日)"
        @attend.user.paidholi_sum -= 0.5
      end  
    else
      @attend = Attend.new(
        user_id: @current_user.id,
        date: params[:date],
        remark: params[:remark]
        )
        
      if params[:remark] == "有給(1日)"
        @attend.user.paidholi_sum -= 1
      elsif params[:remark] == "有給(半日)"
        @attend.user.paidholi_sum -= 0.5
      end  
    end
      
    if @attend.save
      flash[:notice] = "備考を登録しました"
      redirect_to("/mypage")
    else
      render("users/mypage")
    end
    
  end
  
  def destroy_attend
    @attend = Attend.find_by(id: params[:id])
    @attend.destroy
    flash[:notice] = "勤務データを削除しました"
    redirect_to("/mypage")
  end
  
  def new
    @user = User.new
    @department=Department.new
  end
  
  def create
    @user = User.new(
      name: params[:name], 
      number: params[:number],
      password: params[:password],
      address: params[:address]
      )

    if @user.save
      session[:user_id]=@user.id
      
      @department = Department.new(
        user_id: @user.id,
        department: params[:department],
        position: params[:position]
        )
        
      if @department.department == "社長" || @department.department == "人事部" || @department.position == "部長"
        @user.authority = 1
      else
        @user.authority = 0
      end
        
      if @user.save && @department.save
        flash[:notice] = "ユーザー登録が完了しました"
        redirect_to("/show/#{@user.id}")
      else
        render("users/new")
      end
    else
      render("users/new")
    end
  end
  
  def login_form
    
  end
  
  def login
    @user=User.find_by(number: params[:number])
   
    if @user && @user.authenticate(params[:password])
      session[:user_id]=@user.id
      flash[:notice]="ログインしました"
      redirect_to("/mypage")
    else
      @error_message="社員番号またはパスワードが間違っています"
      @number=params[:number]
      @password=params[:password]
      render("users/login_form")
    end
  end
  
  def logout
    session[:user_id]=nil
    flash[:notice]="ログアウトしました"
    redirect_to("/login")
  end
  
  def index
    @departments = Department.all
  end
  
  def show
    @user = User.find_by(id:params[:id])
  end
  
  def paidholi
    @user =User.find_by(id: params[:id])
    @user.paidholi_sum = params[:paidholi_sum]
    
    if @user.save
      flash[:notice] = "有給日数を編集しました"
      redirect_to("/show/#{@user.id}")
    else
      render("users/show")
    end
  end
  
  def paidholi_plusten
    @user = User.find_by(id: params[:id])
    @user.paidholi_sum += 10
    
    if @user.save
      flash[:notice] = "有給日数を編集しました"
      redirect_to("/show/#{@user.id}")
    else
      render("users/show")
    end
  end
  
  def edit
    @user = User.find_by(id: @current_user.id)
  end
  
  def update
    @user = User.find_by(id: @current_user.id)
    @user.name = params[:name]
    @user.password = params[:password]
    @user.address = params[:address]
    
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/mypage")
    else
      render("users/edit")
    end
  end
  
  def destroy
    @department = Department.find_by(id: params[:id])
    @user = User.find_by(id: @department.user_id)
    @department.destroy
    flash[:notice] = "削除しました"
    redirect_to("/show/#{@user.id}")
  end
  
  def edit_depa
    @department=Department.find_by(id: params[:id])
  end
  
  def update_depa
    @department = Department.find_by(id: params[:id])
    @department.department = params[:department]
    @department.position = params[:position]
    
    if @department.department == "社長" || @department.department == "人事部" || @department.position == "部長"
      @department.user.authority = "1"
    end
    
    if @department.save
      flash[:notice] = "配属部署を編集しました"
      redirect_to("/show/#{@department.user.id}")
    else
      render("users/edit_depa")
    end
  end
  
  def ensure_correct_user
    if @current_user.authority != 1
      flash[:notice] = "アクセス権限がありません"
      redirect_to("/mypage")
    end
  end
  
end
