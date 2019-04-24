class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.text :life_objective
      t.integer :selected_mission
      t.integer :selected_vision
      t.integer :critical_success_factors_selected

      t.timestamps
    end
  end
end
