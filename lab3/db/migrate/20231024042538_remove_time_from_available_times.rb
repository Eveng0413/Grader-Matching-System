class RemoveTimeFromAvailableTimes < ActiveRecord::Migration[7.0]
  def change
    remove_column :available_times, :time
  end
end
