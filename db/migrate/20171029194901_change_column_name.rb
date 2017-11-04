class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :page_contents, :conent, :content
  end
end
