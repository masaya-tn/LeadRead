class CreateActions < ActiveRecord::Migration[5.2]
  def change
    create_table :actions do |t|
      t.text :action, null: false
      t.boolean :notion, null: false, default: false
      t.string :book_title, null: false
      t.string :book_image
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
