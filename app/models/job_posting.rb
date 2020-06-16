class JobPosting < ActiveRecord::Base

    has_many :applications
    has_many :users, through: :applications


    def self.get_job_id
        puts "Please enter the Job Posting ID #:"
        job_post_id = gets.chomp
        @job_post_id = job_post_id
    end


end