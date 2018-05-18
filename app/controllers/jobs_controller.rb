class JobsController < ApplicationController
  def new_job
    @job = Job.new
  end
  
  def create_job
    @job = Job.new(
      start: params[:start], 
      finish: params[:finish],
      place: params[:place],
      description: params[:description]
      )
      
    @job.user_id = @current_user.id

    if @job.save
      flash[:notice] = "新規業務登録が完了しました"
      redirect_to("/jobs/show/#{@job.id}")
    else
      render("jobs/new_job")
    end
  end
  
  def show_job
    @job = Job.find_by(id: params[:id])
  end
  
  def index_job
    @user = User.find_by(id: params[:id])
    @jobs = @user.jobs
  end
end
