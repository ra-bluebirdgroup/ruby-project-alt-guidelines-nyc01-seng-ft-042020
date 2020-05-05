class CreateUserUsaRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :user_usa_records do |t|
       t.integer :user_id
       t.integer :usa_id

    end
  end
end
