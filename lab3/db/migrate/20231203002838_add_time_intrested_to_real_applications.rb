class AddTimeIntrestedToRealApplications < ActiveRecord::Migration[7.0]
  def change
    add_column :real_applications, :time_intrested, :string
  end
end
