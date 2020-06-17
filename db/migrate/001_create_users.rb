class CreateUsers < ActiveRecord::Migration[5.2]

    def change
        create_table :users do |t|
            t.string :name
            t.date :dob
            t.string :location
            t.string :degree
            t.integer :years_experience
            t.boolean :employed
        end
    end
   
end