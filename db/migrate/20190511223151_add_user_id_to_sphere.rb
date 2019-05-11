class AddUserIdToSphere < ActiveRecord::Migration[5.2]
  def change
    add_column :spheres, :user_id, :integer
  end
end
