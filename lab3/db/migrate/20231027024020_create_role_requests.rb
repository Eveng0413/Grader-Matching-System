class CreateRoleRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :role_requests do |t|
      t.string :email, null: false
      t.string :role_requested, null: false
      t.string :status, default: 'pending', null: false

      t.timestamps
    end
    add_index :role_requests, :email, unique: true

  end
end
