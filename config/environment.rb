require 'bundler'
Bundler.require

# require_all 'models'
require_all 'lib'

        
require_relative '../app/models/application.rb'
require_relative '../app/models/cli.rb'
require_relative '../app/models/job_posting.rb'
require_relative '../app/models/user.rb'

# require_relative '../db/seeds.rb'

ActiveRecord::Base.establish_connection(
    adapter: 'sqlite3', 
    database: 'db/development.db'
    )
