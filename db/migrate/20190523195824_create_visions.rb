class CreateVisions < ActiveRecord::Migration[5.2]
  def change
    create_table :visions do |t|
      t.text :where_im_going
      t.text :where_arrive
      t.text :how_complete_mission
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
