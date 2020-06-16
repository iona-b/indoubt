require_relative '../config/environment'

system("clear")
app = CLI.new
app.create_profile
# app.submit_application
# app.saved_job_postings
# app.search_for_job_positions

# puts "HELLO WORLD"


require 'pry'

binding.pry