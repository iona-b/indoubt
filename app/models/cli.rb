require 'tty-prompt'
class CLI

    attr_accessor :name, :dob, :location, :degree, :years_experience, :employed, :user_id, :job_posting_id

    # def main_menu
    #     puts "Welcome to the job search app!"
    #     puts "You have the following job search options:"
    #     puts "1. Create User Profile"
    #     puts "2. Update User Profile"
    #     puts "3. Search for Job Positions"
    #     puts "4. Apply for a Job"
    #     puts "5. View Your Job Applications"
    #     puts "6. Delete Your Job Applications"
    #     puts "7. Delete Your Profile"
    #     puts "8. Exit menu"
    #     puts "What would you like to do? Please enter a number between 1 and 7:"
    #     user_choice = gets.chomp
    #     while user_choice
    #         if user_choice.to_i == 1
    #             create_profile
    #         elsif user_choice.to_i == 2
    #             # Update profile options
    #         elsif user_choice.to_i == 3
    #             find_matching_job_positions
    #         elsif user_choice.to_i == 4
    #             submit_application
    #         elsif user_choice.to_i == 5
    #             saved_job_postings
    #         elsif user_choice.to_i == 6
    #             delete_all_applications
    #         elsif user_choice.to_i == 7
    #             delete_user
    #         elsif user_choice.to_i == 8
    #             # Exit method
    #         else "Please enter a number between 1 and 7:"
    #             user_choice = gets.chomp
    #             user_choice.to_i
    #         end
    #     end
    # end

    # TTY::PROMPT.new.select(...)

    # attr_accessor :prompt
    # def initialize
    #     @prompt = TTY::PROMPT.new
    # end

    # prompt = TTY::PROMPT.new

    def main_menu
        prompt = TTY::Prompt.new
        prompt.select("Welcome to the job search app!/nWhat would you like to do?") do |menu|
            menu.choice "Create User Profile", -> {create_profile}
            menu.choice "Update User Profile", -> {update_profile}
            menu.choice "Search for Job Positions", -> {find_matching_job_positions}
            menu.choice "Apply for a Job", -> {submit_applications}
            menu.choice "View Your Job Applications", -> {jobs_applied}
            menu.choice "Delete Your Job Applications", -> {delete_all_applications}
            menu.choice "Delete Your Profile", -> {delete_user}
            menu.choice "Exit", -> {return}
        end
    end
 
    def create_profile # User Story 1
        puts "Hi there! Let's create a profile for your job search."
        User.get_user_name
        User.get_dob
        User.get_user_location
        User.get_degree
        User.get_experience
        User.employed?
        user_id = User.create_profile
    end

    # def update_profile
    #     puts "You can update the following details:"
    #     puts "1. Location"
    #     puts "2. Employment Status"
    #     puts "3. Years of Experience"
    #     puts "Please enter a number between 1 and 3:"
    #     user_choice = gets.chomp
    #     if user_choice == "1"
    #         User.update_location
    #     elsif user_choice == "2"
    #         User.update_employment_status
    #     elsif user_choice == "3"
    #         User.update_years_experience
    #     else
    #         puts "Please enter a valid menu option:"
    #         # Need to add loop
    #     end
    # end

    def update_profile
        prompt = TTY::Prompt.new
        prompt.select("You can update the following details:") do |menu|
            menu.choice "Location", -> {User.update_location}
            menu.choice "Employment Status", -> {User.update_employment_status}
            menu.choice "Years of Experience", -> {User.update_years_experience}
            # menu.choice "Degree", -> {User.update_degree}
            menu.choice "Exit", -> {return}
        end
    end

    def get_search_criteria # User Story 4
        puts "Thank you for beginning your job search with us! In order to find the job which will suit you best, we'll need some more information from you."
        @current_user = User.get_current_user
        @job_title = User.get_job_title
        @salary = User.get_preferred_salary
        @contract_type = User.get_contract_type
        @remote = User.remote?
        @location = @current_user.location
        @years_experience = @current_user.years_experience
        @degree = @current_user.degree
    end

    def find_matching_job_positions # User Story 4
        get_search_criteria
        puts "We are now searching for jobs based on your criteria."
        jobs = []
        jobs_full_description = []
        jobs = JobPosting.where("job_title = ? AND location = ? AND years_experience <= ? AND degree_required = ? AND salary >= ? AND remote = ?", @job_title, @location, @years_experience, @degree, @salary, @remote)
        jobs.map { |job| jobs_full_description << "#{job.job_title} in #{job.location}: $#{job.salary} per/year." }
        puts "We currently have #{jobs.count} jobs matching your search:"
        puts jobs_full_description
    end

    def submit_application
        prompt = TTY::Prompt.new
        answer = prompt.select("Ready to submit your application?", %w(Yes No))
        if answer == "Yes"
            Application.application_submit
        else
            puts "Okay."
        end
    end

    # def submit_application
    #     TTY::Prompt.new.select("Ready to submit your application?", %w(Yes No))
    #     if answer == "Yes"
    #         Application.application_submit
    #     else
    #         # puts "Sorry, that job posting does not exist or is no longer an active job posting."
    #         puts "Okay."
    #     end
    # end

    def saved_job_postings # User Story 5
        User.get_current_user
        puts "Would you like to save a job posting?"
        JobPosting.get_job_id
        post_id = Application.find(job_post_id)
        if post_id
            if saved_postings.include?(post_id) 
                puts "This job posting has already been saved"
            else
                saved_postings << post_id
                puts "Job post #{job_post_id} #{post_id.title} has been saved."
            end
        else
            puts "Sorry, that job posting does not exist or is no longer an active job posting."
        end
        saved_postings
    end

    def jobs_applied # User Story 6
        Application.submitted_applications
    end

    # def self.delete_user # User Story 8
    #     User.get_current_user
    #     puts "Please confirm that you would like to delete your profile. Please enter yes or no:"
    #     answer = gets.chomp
    #     if answer == "yes"
    #         # user = User.find(@user_id)
    #         current_user.destroy
    #         puts "Your profile has successfully been deleted."
    #     else
    #         puts "Your profile remains active."
    #     end
    # end 
    
    def self.delete_user # User Story 8
        User.get_current_user
        prompt = TTY::Prompt.new
        prompt.select("Please confirm that you would like to delete your profile:") do |menu|
            menu.choice "Yes! I would like to delete my profile.", -> { current_user.destory}
            menu.choice "No! Don't delete my profile", -> { return}
        end
    end

    # def delete_all_applications # User Story 9
    #     User.get_current_user
    #     puts "Please confirm that you would like to delete all of your applications. Please enter yes or no:"
    #     answer = gets.chomp
    #     if answer == "yes"
    #         @@submitted_applications./n/n
    #         puts "All of your applications have been deleted."
    #     else
    #         puts "No applications have been deleted."
    #     end
    # end

    def delete_all_applications # User Story 9
        User.get_current_user
        PROMPT.select("Please confirm that you would like to delete all of your applications:") do |menu|
            menu.choice "Yes! I would like to delete my applications.", -> { @@submit_applications./n/n}
            menu.choice "No! Don't delete my applications.", -> { return} 
        end  
    end

    # def self.delete_application # User Story 10
    #   User.get_current_user
    #   puts "Please confirm that you would like to delete this application. Please enter yes or no:"
    #   answer = gets.chomp
    #   if answer == "yes"
    #       @@submitted_applications./n/n
    #       puts "This application has been deleted."
    #   else
    #       puts "No applications have been deleted."
    #   end
    # end
end

# end

# method at end of methods to return to menu