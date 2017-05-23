require_relative 'utils'

Sequel.migration do

  up do
    create_table(:department_list) do
      primary_key :id

      Integer :lock_version, :default => 0, :null => false
      Integer :repo_id, :null => false, :unique => true
      MediumBlobField :codes, :null => false
      String :default_value, :null => true

      apply_mtime_columns
    end

    alter_table(:department_list) do
      add_foreign_key([:repo_id], :repository, :key => :id)
    end

    # Create a blank list for each extant repository
    self[:repository].all.each do |row|
      id = row[:id]

      values = {
        :repo_id => id,
        :codes => blobify(self, '[]'),
      }

      [:create_time, :system_mtime, :user_mtime].each do |time|
        values[time] = Time.now
      end

      [:created_by, :last_modified_by].each do |mod|
        values[mod] = 'admin'
      end

      self[:department_list].insert(values)
    end
  end


  down do
  end

end
