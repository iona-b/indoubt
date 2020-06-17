require 'tty-prompt'
class CLI

    attr_accessor :name, :dob, :location, :degree, :years_experience, :employed, :user_id, :job_posting_id

    def main_menu
        prompt = TTY::Prompt.new
        prompt.select("Welcome to the job search app! What would you like to do?") do |menu|
            menu.choice "Create User Profile", -> {create_profile}
            menu.choice "Update User Profile", -> {update_profile}
            menu.choice "Search for Job Positions", -> {find_matching_job_positions}
            menu.choice "Apply for a Job", -> {submit_application}
            menu.choice "View Your Job Applications", -> {jobs_applied}
            menu.choice "Delete Your Job Applications", -> {delete_applications}
            menu.choice "Delete Your Profile", -> {delete_user}
            menu.choice "Exit", -> {exit}
        end
    end
 
    def create_profile
        puts "Hi there! Let's create a profile for your job search."
        User.get_user_name
        User.get_dob
        User.get_user_location
        User.get_degree
        User.get_experience
        User.employed?
        user_id = User.create_profile
        main_menu
    end

    def update_profile
        prompt = TTY::Prompt.new
        prompt.select("You can update the following details:") do |menu|
            menu.choice "Location", -> {User.update_location}
            menu.choice "Employment Status", -> {User.update_employed}
            menu.choice "Years of Experience", -> {User.update_experience}
            menu.choice "Degree", -> {User.update_degree}
            menu.choice "Exit", -> {main_menu}
        end
        main_menu
    end

    def get_search_criteria 
        puts "Thank you for beginning your job search with us! In order to find the job which will suit you best, we'll need some more information from you."
        @current_user = User.get_current_user
        @job_title = JobPosting.get_job_title
        @salary = JobPosting.get_preferred_salary
        @contract_type = JobPosting.get_contract_type
        @remote = JobPosting.remote?
        @location = @current_user.location
        @years_experience = @current_user.years_experience
        @degree = @current_user.degree
    end

    def find_matching_job_positions 
        get_search_criteria
        puts "We are now searching for jobs based on your criteria."
        jobs = []
        jobs_full_description = []
        jobs = JobPosting.where("job_title = ? AND location = ? AND years_experience <= ? AND degree_required = ? AND salary >= ? AND remote = ?", @job_title, @location, @years_experience, @degree, @salary, @remote)
        jobs.map { |job| jobs_full_description << "Job Posting #{job.id}: #{job.job_title} in #{job.location}: $#{job.salary} per/year." }
        puts "We currently have #{jobs.count} jobs matching your search:"
        puts jobs_full_description
        prompt = TTY::Prompt.new
        prompt.select("Would you like to apply for any of these jobs?") do |menu|
            menu.choice "Yes", -> {Application.application_submit}
            menu.choice "No", -> {main_menu}
        end
    end

    def submit_application
        prompt = TTY::Prompt.new
        answer = prompt.select("Ready to submit your application?", %w(Yes No))
        if answer == "Yes"
            Application.application_submit
        else
            return
        end
        main_menu
    end

    def jobs_applied
        Application.submitted_applications
        main_menu
    end

    def delete_applications 
        prompt = TTY::Prompt.new
        prompt.select("Please select from the following choices:") do |menu|
            menu.choice "I would like to delete ONE of my applications.", -> {Application.delete_selected_application}
            menu.choice "I would like to delete ALL of my applications.", -> {Application.delete_all_applications}
            menu.choice "No! Don't delete any applications.", -> {main_menu} 
        end
        main_menu  
    end

    def delete_user 
        prompt = TTY::Prompt.new
        prompt.select("Please confirm that you would like to delete your profile:") do |menu|
            menu.choice "Yes! I would like to delete my profile.", -> {User.delete_user}
            menu.choice "No! Don't delete my profile", -> {main_menu}
        end
        main_menu
    end
end
