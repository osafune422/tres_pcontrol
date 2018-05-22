class AttendsController < ApplicationController
  require 'date'
  
  def attendall_pre2
    @today = Date.today << 2
    @days = @today.beginning_of_month..@today.end_of_month
    @user = User.find_by(id: params[:id])
    @attends = @user.attends.order("date DESC")
  end
  
  def attendall_pre1
    @today = Date.today << 1
    @days = @today.beginning_of_month..@today.end_of_month
    @user = User.find_by(id: params[:id])
    @attends = @user.attends.order("date DESC")
  end
  
  def attendall
    @today = Date.today
    @days = @today.beginning_of_month..@today.end_of_month
    @user = User.find_by(id: params[:id])
    @attends = @user.attends.order("date DESC")
  end
  
  def attendall_next1
    @today = Date.today >> 1
    @days = @today.beginning_of_month..@today.end_of_month
    @user = User.find_by(id: params[:id])
    @attends = @user.attends.order("date DESC")
  end
  
  
end
