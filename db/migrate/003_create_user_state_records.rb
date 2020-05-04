class CreateUserStateRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :user_state_records do |t|
      t.integer :user_id
      t.integer :state_id
    end
  end
end
