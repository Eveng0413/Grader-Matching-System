class CreateSectionApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :section_applications do |t|
      t.integer :course_id
      t.integer :section_id
      t.string :email
      t.string :first_name
      t.string :last_name
      t.text :interests

      t.timestamps
    end
  end
end
