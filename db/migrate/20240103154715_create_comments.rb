class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.text :content
      t.references :discussion_thread, null: false, foreign_key: true

      t.timestamps
    end
  end
end
