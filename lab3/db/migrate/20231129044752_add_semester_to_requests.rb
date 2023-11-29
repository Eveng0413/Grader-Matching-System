class AddSemesterToRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :requests, :semester, :string
  end
end
