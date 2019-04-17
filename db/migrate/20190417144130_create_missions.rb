class CreateMissions < ActiveRecord::Migration[5.2]
  def change
    create_table :missions do |t|
      t.string :purpose_of_life
      t.text :who_am_i
      t.string :why_exist

      t.timestamps
    end
  end
end
