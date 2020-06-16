class Application < ActiveRecord::Base

    belongs_to :user
    belongs_to :job_posting


    def self.application_submit
        current_user = User.get_current_user
        job_id = JobPosting.get_job_id
        application = Application.create(user_id: current_user, job_posting_id: job_id, status: true)
        puts "Your application has been submitted! Your application ID # is #{application.id}."
    end


end