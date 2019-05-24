class RenameCriticalSuccessFactorsSelectedToSelectedCsfOnPlan < ActiveRecord::Migration[5.2]
  def change
    rename_column :plans, :critical_success_factors_selected, :selected_csf
  end
end
