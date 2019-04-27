class AddNameAndSelectedPlanToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :selected_plan, :integer
  end
end
