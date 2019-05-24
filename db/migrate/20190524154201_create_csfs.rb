class CreateCsfs < ActiveRecord::Migration[5.2]
  def change
    create_table :csfs do |t|
      t.text :what_makes_me_unique
      t.text :best_attributes
      t.text :essential_atributes
      t.text :health_factors
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
