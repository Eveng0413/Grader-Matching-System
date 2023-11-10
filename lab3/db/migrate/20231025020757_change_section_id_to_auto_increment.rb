class ChangeSectionIdToAutoIncrement < ActiveRecord::Migration[7.0]
  def change
    change_column :sections, :section_id, :integer, auto_increment: true
  end
end
