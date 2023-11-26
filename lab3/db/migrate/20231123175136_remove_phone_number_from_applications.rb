class RemovePhoneNumberFromApplications < ActiveRecord::Migration[7.0]
  def change
    remove_column :applications, :phone_number, :string
  end
end
