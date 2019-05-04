class CreateStrengths < ActiveRecord::Migration[5.2]
  def change
    create_table :strengths do |t|
      t.references :plan, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
