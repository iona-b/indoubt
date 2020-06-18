class User < ActiveRecord::Base

    has_many :applications
    has_many :job_postings, through: :applications

    attr_accessor :current_user

    def self.get_user_name
        puts "Please enter your name:"
        name = gets.chomp
        @name = name
    end
    
    def self.get_current_user
        puts "Please enter your User ID #:"
        current_user_id = gets.chomp
        @current_user = self.where("id = ?", current_user_id)[0]
        system "clear"
        @current_user
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

    def self.update_location
        user = @current_user
        puts "Please enter your new location:"
        location = gets.chomp
        user.location = location
        user.save
        system "clear"
        puts "Thank you! Your location has now been updated."
    end

    def self.get_degree
        prompt = TTY::Prompt.new
        degree = prompt.select("Please select your highest degree:") do |menu|
            menu.choice "None"
            menu.choice "High School"
            menu.choice "Bachelors"
            menu.choice "Masters"
            menu.choice "Phd"
        end
        @degree = degree
    end

    def self.update_degree
        user = @current_user
        user.degree = User.get_degree
        user.save
        system "clear";
        puts "Thank you! Your degree has now been updated."
    end

    def self.get_experience
        puts "Please enter how many years of experience you have:"
        years_experience = gets.chomp
        @years_experience = years_experience
    end

    def self.update_experience
        user = @current_user
        puts "Please enter how many years experience you have:"
        years_experience = gets.chomp
        user.years_experience = years_experience.to_i
        user.save
        system "clear";
        puts "Thank you! Your experience has now been updated."
    end

    def self.employed?
        prompt = TTY::Prompt.new
        employed = prompt.select("Are you currently employed?:") do |menu|
            menu.choice "Yes"
            menu.choice "No"
        end
        if employed == "Yes"
            employed = true
        elsif
            employed == "No"
            employed = false
        end
        @employed = employed
    end

    def self.update_employed
        user = @current_user
        user.employed = User.employed?
        user.save
        system "clear";
        puts "Thank you! Your employment status has now been updated."
    end

    def self.create_profile
        user = User.create(name: @name, dob: @dob, location: @location, degree: @degree, years_experience: @years_experience, employed: @employed)
        @user_id = user.id
        system "clear";
        puts "Thank you! We are now creating your user profile."
        puts "Your User ID is #{@user_id}."
    end
      
    def self.delete_user
        puts "For security, we require that you confirm your User ID #."
        current_user = self.get_current_user
        current_user.destroy
        system "clear";
        puts "Your profile has been deleted."
    end

    def self.average_experience
        experience = self.all.map {|user| user.years_experience.to_i}.sum
        average = experience.to_f/self.all.count
        rounded_average = average.round(1)
        puts "The average experience for all users is #{rounded_average} years."
    end
end