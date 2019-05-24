class CreateValues < ActiveRecord::Migration[5.2]
  def change
    create_table :values do |t|
      t.string :name
      t.references :plan, foreign_key: true

      t.timestamps
    end
  end
end
