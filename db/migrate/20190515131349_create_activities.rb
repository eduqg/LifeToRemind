class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :title
      t.boolean :checked
      t.references :goal, foreign_key: true

      t.timestamps
    end
  end
end
