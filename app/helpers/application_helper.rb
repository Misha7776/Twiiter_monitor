module ApplicationHelper
  def job_status(job_id)
  	binding.pry
    Sidekiq::Status::complete?(job_id)  
  end 
end
