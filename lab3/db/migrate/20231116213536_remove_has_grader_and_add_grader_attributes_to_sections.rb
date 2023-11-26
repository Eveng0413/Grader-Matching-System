class RemoveHasGraderAndAddGraderAttributesToSections < ActiveRecord::Migration[6.0]
  def change
    remove_column :sections, :has_grader, :boolean
    add_column :sections, :grader_needed, :integer
    add_column :sections, :grader, :string
  end
end
