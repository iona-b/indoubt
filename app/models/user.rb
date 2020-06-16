class User < ActiveRecord::Base

    has_many :applications
    has_many :job_postings, through: :applications

    @@submitted_applications = []

    def self.get_user_name
        puts "Please enter your name:"
        name = gets.chomp
        @name = name
    end
    
    def self.get_current_user_id
        puts "Please enter your User ID #:"
        current_user_id = gets.chomp
        current_user = self.where("id = ?", current_user_id)
        # @current_user = current_user
        puts current_user        
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
        puts "Please enter your highest degree:"
        degree = gets.chomp
        @degree = degree
    end

    def self.get_experience
        puts "Please enter how many years of experience you have:"
        years_experience = gets.chomp
        @years_experience = years_experience
    end

    def self.employed?
        puts "Are you currently employed? Please enter yes or no:"
        employed = gets.chomp
        if employed == "yes"
            employed = true
        else
            employed = false
        end
        @employed = employed
    end

    def self.get_job_title
        puts "Please enter the job title you are searching for:"
        job_title = gets.chomp
        @job_title = job_title
    end

    def self.get_preferred_salary
        puts "Please enter your preferred minimum salary:"
        salary = gets.chomp
        @salary = salary
    end

    def self.get_contract_type
        puts "Please tell us whether you are interested in a part-time or full-time position"
        contract = gets.chomp
        @contract = contract
    end

    def self.remote?
        puts "Would you prefer to work remotely?"
        remote = gets.chomp
        if remote == "Yes"
            remote = true
        else
            remote = false
        end
    end

    def self.create_profile
        user = User.create(name: @name, dob: @dob, location: @location, degree: @degree, years_experience: @years_experience, employed: @employed)
        @user_id = user.id
    end

    def self.read_user_profile
        
    end

end