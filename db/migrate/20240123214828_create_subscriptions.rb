class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :tea, null: false, foreign_key: true
      t.string :title
      t.integer :price
      t.integer :status
      t.integer :frequency

      t.timestamps
    end
  end
end
