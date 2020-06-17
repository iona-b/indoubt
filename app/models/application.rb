require_relative '../models/cli.rb'

class Application < ActiveRecord::Base

    belongs_to :user
    belongs_to :job_posting


    def self.application_submit
        current_user = User.get_current_user
        job_id = JobPosting.get_job_id
        application = Application.create(user_id: current_user.id, job_posting_id: job_id, status: true)
        puts "Your application has been submitted! Your application ID # is #{application.id}."
        # CLI.main_menu
    end

    def self.submitted_applications
        current_user = User.get_current_user
        @application = Application.where("user_id = ?", current_user.id)

        i = 0
        while i < application.length
            job = JobPosting.where("id = ?", @application[i].job_posting_id)
            puts "Application ##{@application[i].id} for the position of #{job[i].job_title} in #{job[i].location}.
        end

        # job = JobPosting.where("id = ?", @application[0].job_posting_id)
        # puts "You have #{@application.count} open application(s)."
        # puts "Application ##{@application[0].id} for the position of #{job[0].job_title} in #{job[0].location}."
        # CLI.main_menu
    end

    def self.delete_selected_application
        current_user = User.get_current_user
        all_applications = self.all.where("user_id = ?", current_user.id)
        puts "Please enter the application ID # for the application you wish to delete:"
        application_id = gets.chomp
        application = all_applications.where("id = ?", application_id)
        application.destroy_all
        puts "Your application with ID # #{application_id} has been deleted."
        # CLI.main_menu
    end

    def self.delete_all_applications
        current_user = User.get_current_user
        all_applications = self.all.where("user_id = ?", current_user.id)
        all_applications.destroy_all
        puts "Your applications have been deleted."
        # CLI.main_menu
    end

end