class AddProgressToSphere < ActiveRecord::Migration[5.2]
  def change
    add_column :spheres, :progress, :float
  end
end
