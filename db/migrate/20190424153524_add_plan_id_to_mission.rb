class AddPlanIdToMission < ActiveRecord::Migration[5.2]
  def change
    add_column :missions, :plan_id, :integer
  end
end
