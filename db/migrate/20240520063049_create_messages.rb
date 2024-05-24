class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :current_user_id
      t.text :direction
      t.boolean :is_read

      t.timestamps
    end
  end
end
