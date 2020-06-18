require_relative '../config/environment'
require 'rest-client'
require 'pry'

system("clear")
app = CLI.new
app.login

# puts "HELLO WORLD"
# binding.pry