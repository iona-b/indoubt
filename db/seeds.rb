# User.destroy_all
# JobPosting.destroy_all
# Application.destroy_all

require_relative '../app/models/application.rb'
require_relative '../app/models/cli.rb'
require_relative '../app/models/job_posting.rb'
require_relative '../app/models/user.rb'
require_relative '../app/adapter/api_link.rb'

# GitHubJob.get_data("Engineer")

# require 'faker'
# include Faker

# degree_options =["None", "High School", "Bachelors", "Masters", "Phd"]
# city_options = ["San Francisco", "Seattle", "Portland", "Los Angeles", "San Diego", "New York"]
# degree_options =["Bachelors", "Masters", "Phd"]
# contract_type =["Full Time", "Part Time"]

# 25.times do
#     JobPosting.create(
#         location: city_options.sample,
#         job_title: "Senior Software Engineer",
#         salary: Faker::Number.between(120000, 250000),
#         contract_type: contract_type.sample,
#         remote: Faker::Boolean.boolean,
#         years_experience: Faker::Number.between(1, 5),
#         degree_required: degree_options.sample
#     )
# end

# 50.times do
#     User.create(
#         name: Faker::Name.name,
#         dob: Faker::Date.between(50.years.ago, 18.years.ago),
#         location: city_options.sample,
#         degree: degree_options.sample,
#         years_experience: Faker::Number.between(1, 10),
#         employed: Faker::Boolean.boolean
#     )
# end

# 50.times do
#     Application.create(
#         user_id: Faker::Number.between(19, 69),
#         job_posting_id: Faker::Number.between(1, 87)
#     )
# end

puts "Seeds done!"