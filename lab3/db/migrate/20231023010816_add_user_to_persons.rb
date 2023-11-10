class AddUserToPersons < ActiveRecord::Migration[7.0]
  def change
    add_reference :persons, :user, null: false, foreign_key: true
  end
end
