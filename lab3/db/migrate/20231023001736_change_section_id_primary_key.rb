class ChangeSectionIdPrimaryKey < ActiveRecord::Migration[7.0]
  def change
    # Remove the primary key constraint from course_id
    change_column :sections, :section_id, :integer, primary_key: false

    # Add a new column c_id and make it the primary key
    add_column :sections, :s_id, :integer, primary_key: true, auto_increment: true
  end
end
