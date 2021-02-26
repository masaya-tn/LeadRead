class AddBookInfoToOutput < ActiveRecord::Migration[5.2]
  def change
    add_column :outputs, :book_title, :string, null: false
    add_column :outputs, :auther, :string
    add_column :outputs, :book_image, :string
  end
end
