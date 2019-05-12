class ChangeColumnLifeObjectiveToNameOnPlan < ActiveRecord::Migration[5.2]
  def change
    rename_column :plans, :life_objective, :name
  end
end
