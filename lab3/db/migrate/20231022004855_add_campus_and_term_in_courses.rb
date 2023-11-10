class AddCampusAndTermInCourses < ActiveRecord::Migration[7.0]
  def change
    add_column :courses, :campus, :string
    add_column :courses, :term, :string
  end
end
