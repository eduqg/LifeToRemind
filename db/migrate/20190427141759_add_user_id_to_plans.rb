class AddUserIdToPlans < ActiveRecord::Migration[5.2]
  def change
    add_reference :plans, :user, foreign_key: true
  end
end
