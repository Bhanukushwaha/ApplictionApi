class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :title
      t.integer :user_id
      t.integer :post_id

      t.timestamps
    end
  end
end
