class RenameApplicationsToGraderApplications < ActiveRecord::Migration[7.0]
  def change
    rename_table :applications, :grader_applications
  end
end
