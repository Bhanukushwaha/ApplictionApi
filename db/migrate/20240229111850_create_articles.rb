class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :first_name
      t.string :last_name
      t.string :mobile_num

      t.timestamps
    end
  end
end
