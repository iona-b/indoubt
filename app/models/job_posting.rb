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

end