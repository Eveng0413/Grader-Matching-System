class ChangSectionStartEndTimeType < ActiveRecord::Migration[7.0]
  def change
    # Remove the primary key constraint from course_id
    change_column :sections, :start_time, :string
    # Remove the primary key constraint from course_id
    change_column :sections, :end_time, :string
  end
end
