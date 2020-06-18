require 'tty-prompt'
class CLI

    attr_accessor :name, :dob, :location, :degree, :years_experience, :employed, :user_id, :job_posting_id

    def main_menu
        prompt = TTY::Prompt.new
        prompt.select("Welcome to InDoubt, the #1 rated job search app! What would you like to do?") do |menu|
            menu.choice "Create User Profile", -> {system "clear"; create_profile}
            menu.choice "View User Profile", -> {system "clear"; view_profile}
            menu.choice "Update User Profile", -> {system "clear"; update_profile}
            menu.choice "Search for Job Positions", -> {system "clear"; find_matching_job_positions}
            menu.choice "View Job Statistics", -> {system "clear"; statistics_menu}
            menu.choice "Apply for a Job", -> {system "clear"; submit_application}
            menu.choice "View Your Job Applications", -> {system "clear"; jobs_applied}
            menu.choice "Delete Your Job Applications", -> {system "clear"; delete_applications}
            menu.choice "Delete Your Profile", -> {system "clear"; delete_user}
            menu.choice "Exit", -> {system "clear"; exit}
        end
    end

    def statistics_menu
        prompt = TTY::Prompt.new
        prompt.select("Welcome to the statistics menu. What would you like to do?") do |menu|
            menu.choice "View the average salary by job title and city.", -> {system "clear"; JobPosting.average_salary_location_title}
            menu.choice "View the average salary by job title.", -> {system "clear"; JobPosting.average_salary_title}
            menu.choice "View the average salary by city.", -> {system "clear"; JobPosting.average_salary_location}
            menu.choice "View the average experience required for jobs.", -> {system "clear"; JobPosting.average_experience_title}
            menu.choice "View the average experience of all users.", -> {system "clear"; User.average_experience}
            menu.choice "Exit", -> {system "clear"; main_menu}
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
        system "clear";
        user_id = User.create_profile
        main_menu
    end

    def update_profile
        prompt = TTY::Prompt.new
        prompt.select("You can update the following details:") do |menu|
            menu.choice "Location", -> {system "clear"; User.update_location}
            menu.choice "Employment Status", -> {system "clear"; User.update_employed}
            menu.choice "Years of Experience", -> {system "clear"; User.update_experience}
            menu.choice "Degree", -> {system "clear"; User.update_degree}
            menu.choice "Exit", -> {system "clear"; main_menu}
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
        jobs = JobPosting.where("job_title LIKE ? AND location LIKE ? AND years_experience <= ? AND degree_required = ? AND salary >= ? AND remote = ?", "%#{@job_title}%", "%#{@location}%", @years_experience, @degree, @salary, @remote)
        jobs.map { |job| jobs_full_description << "Job Posting #{job.id}: #{job.job_title} in #{job.location}: $#{job.salary} per/year." }
        job_count = jobs.count
        system "clear"
        puts "We currently have #{job_count} jobs matching your search:"
        puts jobs_full_description
        prompt = TTY::Prompt.new
        prompt.select("Would you like to apply for any of these jobs?") do |menu|
            menu.choice "Yes", -> {system "clear"; Application.application_submit}
            menu.choice "No", -> {system "clear"; main_menu}
        end
        main_menu
    end

    def submit_application
        prompt = TTY::Prompt.new
        answer = prompt.select("Ready to submit your application?", %w(Yes No))
        if answer == "Yes"
            Application.application_submit
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

    def view_profile
        current_user = User.get_current_user
        puts "Welcome #{current_user.name}!"
        puts "Date of Birth: #{current_user.dob}"
        puts "Location: #{current_user.location}"
        puts "Degree: #{current_user.degree}"
        puts "Years of Experience: #{current_user.years_experience}"
        if current_user.employed == true
            employment_status = "Employed"
        else
            employment_status = "Unemployed"
        end
        puts "Employment Status: #{employment_status}"
        main_menu
    end

end
