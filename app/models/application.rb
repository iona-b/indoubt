require_relative '../models/cli.rb'

class Application < ActiveRecord::Base

    belongs_to :user
    belongs_to :job_posting

    def self.application_security
        puts "For security, we require that you confirm your User ID #."
        @current_user = User.get_current_user
    end

    def self.application_submit
        self.application_security
        job_id = JobPosting.get_job_id
        application = Application.create(user_id: @current_user.id, job_posting_id: job_id)
        system "clear"
        puts "Your application has been submitted! Your application ID # is #{application.id}."
    end

    def self.submitted_applications
        self.application_security
        @applications = Application.where("user_id = ?", @current_user.id)
        available_jobs = []
        JobPosting.all.each do |posting|
            @applications.each do |application|
                if posting.id == application.job_posting_id
                    available_jobs << "Application ##{application.id} for the position of #{posting.job_title} in #{posting.location}."
                end
            end
        end
        if @applications.count == 1
            system "clear"
            puts "You have 1 open application."
        else
            applications = @applications.count
            system "clear"
            puts "You have #{applications} open applications."
        end
        puts available_jobs.uniq
    end

    def self.delete_selected_application
        self.application_security
        all_applications = self.all.where("user_id = ?", @current_user.id)
        puts "Please enter the application ID # for the application you wish to delete:"
        application_id = gets.chomp
        application = all_applications.where("id = ?", application_id)
        application.destroy_all
        system "clear"
        puts "Your application with ID # #{application_id} has been deleted."
    end

    def self.delete_all_applications
        self.application_security
        all_applications = self.all.where("user_id = ?", @current_user.id)
        all_applications.destroy_all
        system "clear"
        puts "Your applications have been deleted."
    end

end