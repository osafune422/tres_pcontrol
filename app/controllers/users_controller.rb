class UsersController < ApplicationController
  def mypage
    @user = User.find_by(id:params[:id])
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
      redirect_to("/mypage/#{@user.id}")
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
  
  def edit
    @user = User.find_by(id:params[:id])
  end
  
  def update
    @user = User.find_by(id: params[:id])
    @user.password = params[:password]
    
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/mypage/#{@user.id}")
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
  
  def edit_c
    @user = User.find_by(id: params[:id])
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
      redirect_to("/control/edit/#{@department.user.id}")
    else
      render("users/edit_depa")
    end
  end
  
  def update_c
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.address = params[:address]
    
    if params[:department5] != nil
      if params[:department5] == "社長" || params[:department5] == "人事部" || params[:position5] == "部長"
        @user.authority = "1"
      end
      
      @department5 = Department.new(
        user_id: @user.id,
        department: params[:department5],
        position: params[:position5]
        )
      
      if @user.save && @department5.save
        flash[:notice] = "社員情報を編集しました"
        redirect_to("/show/#{@user.id}")
      else
        render("users/edit_c")
      end
    else
      if @user.save
        flash[:notice] = "社員情報を編集しました"
        redirect_to("/show/#{@user.id}")
      else
        render("users/edit_c")
      end
    end
  end
end
