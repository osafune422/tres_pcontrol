class AttendsController < ApplicationController
  require 'date'
  
  def input_attend
    @user = User.find(params[:id])
    @attend = Attend.new
  end
  
  def create_attend
    @user = User.find(params[:id])
    @attend = Attend.new(
      user_id: @user.id,
      start: params[:start],
      finish: params[:finish],
      rest: params[:rest]*60,
      remark: params[:remark],
      date: params[:date]
      )
    @attend.sum = @attend.finish - @attend.start - @attend.rest  
    
    if params[:remark] == "有給(1日)"
      @user.paidholi_sum -= 1
    elsif params[:remark] == "有給(半日)"
      @user.paidholi_sum -= 0.5
    end
      
    if @user.save && @attend.save
      flash[:notice] = "勤務内容の登録が完了しました"
      redirect_to("/attendall/#{@user.id}")
    else
      render("attends/input_attend")
    end
  end
  
  def edit_attend
    @attend = Attend.find(params[:id])
  end
  
  def destroy_remark
    @attend = Attend.find_by(id: params[:id])
    if @attend.remark == "有給(1日)"
      @attend.user.paidholi_sum += 1
    elsif @attend.remark == "有給(半日)"
      @attend.user.paidholi_sum += 0.5
    end  
    @attend.remark = nil
    
    if @attend.save
      flash[:notice] = "備考の選択を解除"
      redirect_to("/attend/edit/#{@attend.id}")
    else
      render("attends/edit_attend")
    end
  end
  
  def regist_attend
    @attend = Attend.find(params[:id])
    @attend.date = params[:date]
    @attend.start = params[:start]
    @attend.finish = params[:finish]
    @attend.rest = params[:rest]
    @attend.rest = @attend.rest*60
    @attend.remark = params[:remark]
    
    if @attend.finish != nil
      @attend.sum = @attend.finish - @attend.start - @attend.rest
    end
    
    if @attend.save
      flash[:notice] = "変更内容を登録しました"
      redirect_to("/attendall/#{@attend.user_id}")
    else
      render("attends/edit_attend")
    end
  end
  
  def index_attend
    @users=User.all.order("number DESC")
  end
  
  def paidholipage
    @user = User.find(params[:id])
    @attends = @user.attends.order("date DESC")
  end
  
  def attendall_pre3
    @today = Date.today << 3
    @days = @today.beginning_of_month..@today.end_of_month
    @user = User.find_by(id: params[:id])
    @attends = @user.attends
  end
  
  def attendall_pre2
    @today = Date.today << 2
    @days = @today.beginning_of_month..@today.end_of_month
    @user = User.find_by(id: params[:id])
    @attends = @user.attends
  end
  
  def attendall_pre1
    @today = Date.today << 1
    @days = @today.beginning_of_month..@today.end_of_month
    @user = User.find_by(id: params[:id])
    @attends = @user.attends
  end
  
  def attendall
    @today = Date.today
    @days = @today.beginning_of_month..@today.end_of_month
    @user = User.find_by(id: params[:id])
    @attends = @user.attends
    @acutualwork = Actualwork.find_by(user_id: @user.id, year: @today.year, month: @today.month)
    
  end
  
  def attendall_next1
    @today = Date.today >> 1
    @days = @today.beginning_of_month..@today.end_of_month
    @user = User.find_by(id: params[:id])
    @attends = @user.attends
  end
  
  def attendall_next2
    @today = Date.today >> 2
    @days = @today.beginning_of_month..@today.end_of_month
    @user = User.find_by(id: params[:id])
    @attends = @user.attends
  end
  
  def attendall_next3
    @today = Date.today >> 3
    @days = @today.beginning_of_month..@today.end_of_month
    @user = User.find_by(id: params[:id])
    @attends = @user.attends
  end
end
