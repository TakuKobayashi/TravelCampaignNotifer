class CreateBloggerBots < ActiveRecord::Migration[5.2]
  def change
    create_table :blogger_bots do |t|
      t.string :blogger_id, null: false
      t.string :title, null: false
      t.string :tag_names
      t.string :url, null: false
      t.text :campaign_ids, null: false
      t.text :body, null: false, :limit => 16777215
      t.text :rendered_body, :limit => 16777215
      t.timestamps
    end

    add_index :blogger_bots, :blogger_id, unique: true
  end
end
