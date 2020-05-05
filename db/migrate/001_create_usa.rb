class CreateUsa < ActiveRecord::Migration[5.1]
  def change
    create_table :usas do |t|
      t.string :name
      t.integer :positive
      t.integer :negative
      t.integer :pending
      t.integer :hospitalizedCurrently
      t.integer :hospitalizedCumulative
      t.integer :inIcuCurrently
      t.integer :inIcuCumulative
      t.integer :onVentilatorCurrently
      t.integer :onVentilatorCumulative
      t.integer :recovered
      t.integer :death
      t.integer :hospitalized
      t.integer :totalTestResults
    end
  end
end
