class CreateObjectives < ActiveRecord::Migration[5.2]
  def change
    create_table :objectives do |t|
      t.string :name
      t.boolean :concluded
      t.references :plan, foreign_key: true

      t.timestamps
    end
  end
end
