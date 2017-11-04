class CreatePageContents < ActiveRecord::Migration[5.1]
  def change
    create_table :page_contents do |t|
      t.string :conent
      t.string :tag
      t.references :page, foreign_key: true

      t.timestamps
    end
  end
end
