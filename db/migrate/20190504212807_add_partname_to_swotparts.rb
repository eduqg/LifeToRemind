class AddPartnameToSwotparts < ActiveRecord::Migration[5.2]
  def change
    add_column :swotparts, :partname, :integer
  end
end
