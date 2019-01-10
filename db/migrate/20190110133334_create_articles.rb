class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :type
      t.string :title, null: false
      t.string :basic_src, null: false
      t.text :remain_src
      t.text :image_url
      t.integer :crawl_state, null: false, default: 0
      t.text :options
    end

    add_index :articles, :basic_src
  end
end
