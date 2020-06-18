class JobPosting < ActiveRecord::Base

    has_many :applications
    has_many :users, through: :applications


    def self.get_job_id
        puts "Please enter the Job Posting ID #:"
        job_post_id = gets.chomp
        @job_post_id = job_post_id
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
        prompt = TTY::Prompt.new
        contract = prompt.select("Please tell us whether you are interested in a part time or full time position:") do |menu|
            menu.choice "Full Time"
            menu.choice "Part Time"
        end
        @contract = contract
    end

    def self.remote?
        prompt = TTY::Prompt.new
        remote = prompt.select("Would you prefer to work remotely?:") do |menu|
            menu.choice "Yes"
            menu.choice "No"
        end
        if remote == "Yes"
            remote = true
        elsif
            remote == "No"
            remote = false
        end
        @remote = remote
    end

    def self.average_salary_location_title
        puts "Please enter a job title:"
        title_user_input = gets.chomp
        puts "Please enter a city:"
        location_user_input = gets.chomp
        jobs = JobPosting.where("job_title LIKE ? AND location LIKE ?", "%#{title_user_input}%", "%#{location_user_input}%")
        salaries = jobs.map {|job| job.salary }.sum
        average = salaries/jobs.count
        puts "The average salary for a #{title_user_input} in #{location_user_input} is $#{average}."
    end

    def self.average_salary_title
        puts "Please enter a job title, and we will tell you the average salary for that job."
        user_input = gets.chomp
        jobs = JobPosting.where("job_title LIKE ?", "%#{user_input}%")
        salaries = jobs.map {|job| job.salary }.sum
        average = salaries/jobs.count
        puts "The average salary for a #{user_input} is $#{average}."
    end

    def self.average_salary_location
        puts "Please enter a city, and we will tell you the average salary offered in that city."
        user_input = gets.chomp
        jobs = JobPosting.where("location LIKE ?", "%#{user_input}%")
        salaries = jobs.map {|job| job.salary }.sum
        average = salaries/jobs.count
        puts "The average salary in #{user_input} is $#{average}."
    end

    def self.average_experience_title
        puts "Please enter a job title, and we will tell you the average experience necessary for that job."
        user_input = gets.chomp
        jobs = JobPosting.where("job_title LIKE ?", "%#{user_input}%")
        experience = jobs.map {|job| job.years_experience}.sum
        average = experience.to_f/jobs.count
        rounded_average = average.round(1)
        puts "The average experience necessary for an #{user_input} is #{rounded_average} years."
    end
end