class CreateApplications < ActiveRecord::Migration[5.2]

    def change
        create_table :applications do |t|
            t.integer :user_id
            t.integer :job_posting_id
            t.boolean :status
        end
    end
    
end