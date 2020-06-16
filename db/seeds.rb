User.destroy_all
JobPosting.destroy_all
Application.destroy_all

require_relative '../app/models/application.rb'
require_relative '../app/models/cli.rb'
require_relative '../app/models/job_posting.rb'
require_relative '../app/models/user.rb'

# require_relative '../config/environment.rb'

# JobPosting: location, job_title, field, salary, contract_type, remote, years_experience, degree_required
job_posting_1 = JobPosting.create(location: "San Francisco", job_title: "Junior Software Engineer", field: "Software Engineering", salary: 75000, contract_type: "Full Time", remote: false, years_experience: 1, degree_required: "Bachelors")
job_posting_2 = JobPosting.create(location: "Seattle", job_title: "Senior Software Engineer", field: "Software Engineering", salary: 130000, contract_type: "Full Time", remote: true, years_experience: 7, degree_required: "Masters")
job_posting_3 = JobPosting.create(location: "Portland", job_title: "Administrative Assistant", field: "Administrative", salary: 50000, contract_type: "Part Time", remote: false, years_experience: 1, degree_required: "Bachelors")
job_posting_4 = JobPosting.create(location: "Oakland", job_title: "Curator", field: "Culture", salary: 60000, contract_type: "Full Time", remote: false, years_experience: 6, degree_required: "Phd")
job_posting_5 = JobPosting.create(location: "San Francisco", job_title: "Teacher", field: "Education", salary: 65000, contract_type: "Full Time", remote: false, years_experience: 4, degree_required: "Bachelors")
job_posting_6 = JobPosting.create(location: "New York", job_title: "Registered Nurse", field: "Medicine", salary: 90000, contract_type: "Full Time", remote: false, years_experience: 3, degree_required: "Bachelors")
job_posting_7 = JobPosting.create(location: "Los Angeles", job_title: "Dentist", field: "Medicine", salary: 200000, contract_type: "Full Time", remote: false, years_experience: 8, degree_required: "Masters")
job_posting_8 = JobPosting.create(location: "Sacramento", job_title: "Journalist", field: "Media", salary: 30000, contract_type: "Part Time", remote: true, years_experience: 2, degree_required: "Bachelors")
job_posting_9 = JobPosting.create(location: "Seattle", job_title: "First Grade Teacher", field: "Education", salary: 45000, contract_type: "Full Time", remote: false, years_experience: 1, degree_required: "High School")
job_posting_10 = JobPosting.create(location: "New York", job_title: "Senior Software Engineer", field: "Software Engineering", salary: 180000, contract_type: "Full Time", remote: true, years_experience: 8, degree_required: "Bachelors")

# User name, dob, location, degree, years_experience, employed
user_1 = User.create(name: "Anna", dob: 19940404, location: "San Francisco", degree: "Masters", years_experience: 4, employed: true)
user_2 = User.create(name: "Brian", dob: 19971005, location: "Seattle", degree: "High School", years_experience: 2, employed: true)
user_3 = User.create(name: "Brian", dob: 19930902, location: "Seattle", degree: "High School", years_experience: 2, employed: true)
user_4 = User.create(name: "Michael", dob: 19850506, location: "Seattle", degree: "Bachelors", years_experience: 8, employed: true)
user_5 = User.create(name: "Jack", dob: 19980503, location: "Denver", degree: "High School", years_experience: 1, employed: false)
user_6 = User.create(name: "Jasmine", dob: 19920416, location: "New York", degree: "Bachelors", years_experience: 5, employed: false)
user_7 = User.create(name: "Ryan", dob: 19920116, location: "Los Angeles", degree: "High School", years_experience: 4, employed: true)
user_8 = User.create(name: "Louise", dob: 19690705, location: "San Francisco", degree: "Masters", years_experience: 6, employed: true)
user_9 = User.create(name: "Adam", dob: 19800526, location: "Sacramento", degree: "Bachelors", years_experience: 3, employed: false)
user_10 = User.create(name: "Sarah", dob: 19950202,location: "Oakland", degree: "Phd", years_experience: 7, employed: true)


# Job Application user_id, job_posting_id, status
application_1 = Application.create(user_id: 45, job_posting_id: 45, status: false)
application_2 = Application.create(user_id: 46, job_posting_id: 49, status: true)
application_3 = Application.create(user_id: 38, job_posting_id: 41, status: false)
application_4 = Application.create(user_id: 47, job_posting_id: 47, status: true)
application_5 = Application.create(user_id: 42, job_posting_id: 45, status: true)


puts "Seeds done!"



