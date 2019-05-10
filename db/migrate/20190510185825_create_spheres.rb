class CreateSpheres < ActiveRecord::Migration[5.2]
  def change
    create_table :spheres do |t|
      t.string :name

      t.timestamps
    end
  end
end
