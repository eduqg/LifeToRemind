class RemoveColumnPlanIdAndCreateUserIdOnMission < ActiveRecord::Migration[5.2]
  def change
    remove_column :missions, :plan_id
    add_reference :missions, :user, index:true
  end
end
