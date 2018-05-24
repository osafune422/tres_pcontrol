class AttendsController < ApplicationController
  require 'date'
  
  def edit_attend
    @attend = Attend.find_by(id: params[:id])
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
    @attend = Attend.find_by(id: params[:id])
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
