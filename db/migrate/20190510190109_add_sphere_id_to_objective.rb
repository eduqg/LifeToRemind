class AddSphereIdToObjective < ActiveRecord::Migration[5.2]
  def change
    add_column :objectives, :sphere_id, :integer
  end
end
