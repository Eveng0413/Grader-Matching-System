class AddStatusToRealApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :real_applications, :status, :string, default: 'pending'
  end
end
