class AddSemesterToRecommends < ActiveRecord::Migration[7.0]
  def change
    add_column :recommends, :semester, :string
  end
end
