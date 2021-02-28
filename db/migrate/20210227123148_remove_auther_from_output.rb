class RemoveAutherFromOutput < ActiveRecord::Migration[5.2]
  def change
    remove_column :outputs, :auther
  end
end
