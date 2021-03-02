class ChangeActionsToActionPlans < ActiveRecord::Migration[5.2]
  def change
    rename_table :actions, :action_plans
  end
end
