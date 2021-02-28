class RenameActionColumnToActions < ActiveRecord::Migration[5.2]
  def change
    rename_column :actions, :action, :action_content
  end
end
