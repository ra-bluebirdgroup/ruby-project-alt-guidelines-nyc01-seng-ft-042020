class CreateStates < ActiveRecord::Migration[5.1]
  def change
    create_table :states do |t|
      t.string :name
      t.string :dataQualityGrade
      t.integer :positive
      t.integer :negative
      t.integer :recovered
      t.timestamp :lastUpdateEt
      t.integer :death
      t.integer :totalTestResults
    end
  end
end
