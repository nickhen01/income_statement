class CreateStatements < ActiveRecord::Migration[7.1]
  def change
    create_table :statements do |t|
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
