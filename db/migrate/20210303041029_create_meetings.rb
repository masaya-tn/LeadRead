class CreateMeetings < ActiveRecord::Migration[5.2]
  def change
    create_table :meetings do |t|
      t.references :user, foreign_key: true
      t.string :title, null: false
      t.text :description, null: false
      t.integer :capacity, null: false
      t.datetime :date, null: false
      t.boolean :open, null: false, default: true

      t.timestamps
    end
  end
end
