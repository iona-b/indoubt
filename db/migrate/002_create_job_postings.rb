class CreateJobPostings < ActiveRecord::Migration[5.2]

    def change
        create_table :job_postings do |t|
            t.string :location
            t.string :job_title
            t.string :field
            t.integer :salary
            t.string :contract_type
            t.boolean :remote
            t.integer :years_experience
            t.string :degree_required
        end
    end
    
end