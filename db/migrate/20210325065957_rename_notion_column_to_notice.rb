class RenameNotionColumnToNotice < ActiveRecord::Migration[5.2]
  def change
    rename_column :action_plans, :notion, :notice
  end
end
