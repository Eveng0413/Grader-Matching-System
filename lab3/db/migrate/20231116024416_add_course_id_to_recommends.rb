class AddCourseIdToRecommends < ActiveRecord::Migration[7.0]
  def change
    add_column :recommends, :course_id, :integer
  end
end
