class UsersController < ApplicationController
  def mypage
    @user = User.find_by(id:params[:id])
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
  
  def edit_c
    @user = User.find_by(id:params[:id])
    @departments = @user.departments
    
  end
  
  def update_c
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.address = params[:address]
    
    @departments = @user.departments
    i = 1
    @departments.each do |department|
      if i == 1
        @department1 = department
      elsif i == 2
        @department2 = department
      else
        @department3 = department
      end 
      i += 1
    end
    
    @department1.department = params[:department1]
    @department1.position = params[:position1]
    if @department2 != nil
      @department2.department = params[:department2]
      @department2.position = params[:position2]
      if @department3 != nil
        @department3.department = params[:department3]
        @department3.position = params[:position3]
      end
    end
    
    if params[:department4] != nil
      @department4 = Department.new(
        user_id: @user.id,
        department: params[:department4],
        position: params[:position4])
      
      if @department2 == nil
        if @user.save && @department1.save && @department4.save
          flash[:notice] = "ユーザー情報を編集しました"
          redirect_to("/mypage/#{@user.id}")
        else
          render("users/edit_c")
        end
      elsif @department2 != nil && @department3 == nil
        if @user.save && @department1.save && @department2.save && @department4.save
          flash[:notice] = "ユーザー情報を編集しました"
          redirect_to("/mypage/#{@user.id}")
        else
          render("users/edit_c")
        end
      else
        if @user.save && @department1.save && @department2.save && @department3.save && @department4.save
          flash[:notice] = "ユーザー情報を編集しました"
          redirect_to("/mypage/#{@user.id}")
        else
          render("users/edit_c")
        end
      end
    else
      if @department2 == nil
        if @user.save && @department1.save
          flash[:notice] = "ユーザー情報を編集しました"
          redirect_to("/mypage/#{@user.id}")
        else
          render("users/edit_c")
        end
      elsif @department2 != nil && @department3 == nil
        if @user.save && @department1.save && @department2.save
          flash[:notice] = "ユーザー情報を編集しました"
          redirect_to("/mypage/#{@user.id}")
        else
          render("users/edit_c")
        end
      else
        if @user.save && @department1.save && @department2.save && @department3.save
          flash[:notice] = "ユーザー情報を編集しました"
          redirect_to("/mypage/#{@user.id}")
        else
          render("users/edit_c")
        end
      end
    end
  end
end
