class CreateCashFlows < ActiveRecord::Migration[7.1]
  def change
    create_table :cash_flows do |t|
      t.string :type
      t.string :name
      t.float :amount
      t.references :statement, null: false, foreign_key: true

      t.timestamps
    end
  end
end
