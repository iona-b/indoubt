class User < ActiveRecord::Base

    has_many :applications
    has_many :job_postings, through: :applications

    def self.get_user_name
        puts "Please enter your name:"
        name = gets.chomp
        @name = name
    end
    
    def self.get_current_user
        # Validate that the id # exists
        puts "Please enter your User ID #:"
        current_user_id = gets.chomp
        @current_user = self.where("id = ?", current_user_id)[0]
    end

    def self.get_dob
        puts "Please enter your date of birth in the YYYY-MM-DD format:"
        dob = gets.chomp
        @dob = dob
    end

    def self.get_user_location
        puts "Please enter the city you'd like to find a job in:"
        location = gets.chomp
        @location = location
    end

    def self.get_degree
        # Allow user to select degree type from options?
        # puts "Please select your highest degree:"
        # degree = gets.chomp
        # @degree = degree
        prompt = TTY::Prompt.new
        degree = prompt.select("Please select your highest degree:", %w(None HighSchool Bachelors Masters Phd))
        @degree = degree
        puts degree
    end

    def self.get_experience
        # Validate that the user has entered a number
        puts "Please enter how many years of experience you have:"
        years_experience = gets.chomp
        @years_experience = years_experience
    end

    def self.employed?
        employed = nil
        puts "Are you currently employed? Please enter yes or no:"
        while employed != true && employed != false
            employed = gets.chomp
            employed.downcase!
            if employed == "yes"
                employed = true
                @employed = employed
            elsif employed == "no"
                employed = false
                @employed = employed    
            else
                puts "Please enter yes or no:"
            end
        end
    end

    def self.get_job_title
        puts "Please enter the job title you are searching for:"
        job_title = gets.chomp
        @job_title = job_title
    end

    def self.get_preferred_salary
        # Validate that the user has entered a number
        puts "Please enter your preferred minimum salary:"
        salary = gets.chomp
        @salary = salary
    end

    def self.get_contract_type
        # Allow user to select full time or part time from options
        puts "Please tell us whether you are interested in a part-time or full-time position"
        contract = gets.chomp
        @contract = contract
    end

    def self.remote?
        puts "Would you prefer to work remotely?"
        remote = nil
        while remote != true && remote != false
            remote = gets.chomp
            remote.downcase!
            if remote == "yes"
                remote = true
            elsif remote == "no"
                remote = false
            else
                puts "Please enter yes or no:"
            end
        end
        remote
    end

    def self.create_profile
        user = User.create(name: @name, dob: @dob, location: @location, degree: @degree, years_experience: @years_experience, employed: @employed)
        @user_id = user.id
        puts "Thank you! We are now creating your user profile."
        puts "Your User ID is #{@user_id}."
    end

    def self.update_location
        current_user = User.get_current_user
        puts "Please enter your new location:"
        location = gets.chomp
        current_user.location = location
        current_user.save
        puts "Your location has been updated to #{location}."
    end
      
    def self.update_employment_status
        current_user = User.get_current_user
        current_employment_status = nil
        puts "Are you currently employed? Please enter yes or no:"
        while current_employment_status != true && current_employment_status != false
            current_employment_status = gets.chomp
            current_employment_status.downcase!
            if current_employment_status == "yes"
                current_employment_status = true
                current_user.employed = true
                current_user.save
                puts "Thank you. Your employemnt status has now been updated to employed."
            elsif current_employment_status == "no"
                current_employment_status = false
                current_user.employed = false
                current_user.save
                puts "Thank you. Your employemnt status has now been updated to unemployed."
            else
                puts "Please enter yes or no:"
            end
        end
    end

    def self.update_years_experience
        current_user = User.get_current_user
        puts "Please enter how many years experience you have:"
        years_experience = gets.chomp
        current_user.years_experience = years_experience.to_i
        current_user.save
        puts "Your location has been updated to #{years_experience}."
    end

    def self.update_degree
        # Allow user to select degree type from options?
        current_user = User.get_current_user
        puts "Please enter your highest degree:"
        degree = gets.chomp
        current_user.degree = degree
        current_user.save
        puts "Your location has been updated to #{degree}."
    end

end