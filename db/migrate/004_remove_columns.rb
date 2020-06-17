class RemoveColumns < ActiveRecord::Migration[5.2]

    def change
        remove_column :applications, :status
        remove_column :job_postings, :field
    end

end