class CreateFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :follows do |t|
      t.integer :user_id
      t.integer :current_user_id

      t.timestamps
    end
  end
end
