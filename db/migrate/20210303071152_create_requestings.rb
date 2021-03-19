class CreateRequestings < ActiveRecord::Migration[5.2]
  def change
    create_table :requestings do |t|
      t.references :user, foreign_key: true
      t.references :meeting, foreign_key: true

      t.timestamps
      t.index %i[user_id meeting_id], unique: true
    end
  end
end
