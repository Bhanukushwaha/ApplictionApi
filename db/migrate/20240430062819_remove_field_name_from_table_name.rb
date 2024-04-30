class RemoveFieldNameFromTableName < ActiveRecord::Migration[7.0]
  def change
    remove_column :likes, :title, :string
  end
end
