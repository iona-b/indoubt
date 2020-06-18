# JobPosting: location, job_title, field, salary, contract_type, remote, years_experience, degree_required
class GitHubJob
    def self.get_data(job_title)
        url = "https://jobs.github.com/positions.json?description=ruby&page=1"
        res = RestClient.get(url)
        data = res.body
        json_converted = JSON.parse(data)
        remote = ["Yes", "No"]
        degree = ["None", "High School", "Bachelors", "Masters", "Phd"]
        json_converted.map do |job|
            JobPosting.create(location: job["location"], job_title: job["title"], salary: rand(40000..200000), contract_type: job["type"], remote: remote.sample, years_experience: rand(1..10), degree_required: degree.sample)
        end
    end

end
