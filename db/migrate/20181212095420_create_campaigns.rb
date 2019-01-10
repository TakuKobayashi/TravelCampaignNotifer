class CreateCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :campaigns do |t|
      t.string :group_uuid, null: false
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
      t.float :min_cost, null: false, default: 0
      t.float :max_cost, null: false, default: 0
      t.string :cost_currency_unit, null: false, default: "円"
      t.string :departure_place
      t.string :destination_place
      t.text :options
      t.timestamps
    end

    add_index :campaigns, [:start_at, :end_at]
    add_index :campaigns, [:source_type, :source_id]
    add_index :campaigns, :url, unique: true
    add_index :campaigns, :group_uuid
  end
end
