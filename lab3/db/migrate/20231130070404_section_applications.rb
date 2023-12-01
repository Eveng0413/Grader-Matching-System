class SectionApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :section_applications, :flag, :integer
  end
end
