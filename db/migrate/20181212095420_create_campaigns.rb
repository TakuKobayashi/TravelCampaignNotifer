class CreateCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :campaigns do |t|
      t.string :campaign_id
      t.string :source_type
      t.integer :source_id
      t.string :type
      t.string :title, null: false
      t.string :url, null: false
      t.string :shortener_url
      t.text :description
      t.text :image_url
      t.datetime :start_at, null: false
      t.datetime :end_at
      t.integer :limit_amount, limit: 8
      t.text :condition_comment, null: false
      t.text :options
      t.timestamps
    end

    add_index :campaigns, [:start_at, :end_at]
    add_index :campaigns, [:source_type, :source_id]
    add_index :campaigns, :url, unique: true
  end
end
