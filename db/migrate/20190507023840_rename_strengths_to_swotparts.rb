class RenameStrengthsToSwotparts < ActiveRecord::Migration[5.2]
  def change
    rename_table :strengths, :swotparts
  end
end
