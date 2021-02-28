class AddAuthorToOutput < ActiveRecord::Migration[5.2]
  def change
    add_column :outputs, :author, :string
  end
end
