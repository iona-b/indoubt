class CLI
    attr_accessor :name, :dob, :location, :degree, :years_experience, :employed, :user_id, :job_posting_id

    def create_profile # User Story 1
        puts "Welcome to the job search app. Your first step is to create a profile."
        User.get_user_name
        User.get_dob
        User.get_user_location
        User.get_degree
        User.get_experience
        User.employed?
        user_id = User.create_profile
        puts "Thank you! We are now creating your user profile."
        puts "Your User ID is #{user_id}."
    end

    def submit_application #User Story 2
        @@submitted_applications = []
        User.get_current_user_id
        puts "Ready to submit your application?"
        puts "Enter the Job Posting ID # of the job you would like to apply for:"
        job_posting_id = gets.chomp
        @job_posting_id = job_posting_id
        if @job_posting_id
            application = Application.create(user_id: @user_id, job_posting_id: @job_posting_id, status: true)
            @@submitted_applications << application
            puts "Your application has been submitted! Your application ID # is #{application.id}."
        else
            puts "Sorry, that job posting does not exist or is no longer an active job posting."
        end
    end

    def update_location
        puts "Please input user's updated location:"
        location = gets.chomp
        @location = location
      
        puts "User location updated to #{@location}." 
    end
      
    def update_employment_status
        puts "Are you currently employed? Please enter yes or no:"
        employed = gets.chomp
      
        if employed == "yes"
          @employed = true
          puts "User's employment status is now employed"
        elsif employed == "no" 
          @employed = false
          puts "User's employment status is now unemployed"
        end
    end

    def search_for_job_positions # User Story 4
        puts "Thank you for beginning your job search with us! In order to find the job which will suit you best, we'll need some more information from you."
        User.get_current_user_id
        User.get_job_title
        User.get_preferred_salary
        User.get_contract_type
        User.remote?
        # @location = current_user.location
        # @years_experience = current_user.years_experience
        # @degree = current_user.degree
        puts "We are now searching for jobs based on your criteria."
        # JobPosting.where("job_title == @job_title, location == @location, years_experience == @years_experience, degree_required == @degree, salary >= @salary")
    end

    def saved_job_postings # User Story 5
        saved_postings = []
        User.get_current_user_id
        puts "Please enter the Job Posting ID # of the job post you would like to save:"
        job_post_id = gets.chomp
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
        @@submitted_applications
    end

    def .delete_user # User Story 8
        User.get_current_user_id
        puts "Please confirm that you would like to delete your profile. Please enter yes or no:"
        answer = gets.chomp
        if answer == "yes"
            # user = User.find(@user_id)
            current_user.destroy
            puts "Your profile has successfully been deleted."
        else
            puts "Your profile remains active."
        end
    end

    def delete_all_applications # User Story 9
        User.get_current_user_id
        puts "Please confirm that you would like to delete all of your applications. Please enter yes or no:"
        answer = gets.chomp
        if answer == "yes"
            @@submitted_applications.clear
            puts "All of your applications have been deleted."
        else
            puts "No applications have been deleted."
        end
    end

    # def self.delete_application # User Story 10
    #   User.get_current_user_id
    #   puts "Please confirm that you would like to delete this application. Please enter yes or no:"
    #   answer = gets.chomp
    #   if answer == "yes"
    #       @@submitted_applications.clear
    #       puts "This application has been deleted."
    #   else
    #       puts "No applications have been deleted."
    #   end
    # end
end