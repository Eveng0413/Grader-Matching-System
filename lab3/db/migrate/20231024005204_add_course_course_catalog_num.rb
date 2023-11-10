class AddCourseCourseCatalogNum < ActiveRecord::Migration[7.0]
  def change
    # Add a new column catalog_number in courses
    add_column :courses, :catalog_number, :string
  end
end
