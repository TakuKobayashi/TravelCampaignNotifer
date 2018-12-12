class CreateCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :campaigns do |t|
      t.string :campaign_id
      t.string :type
      t.string :title, null: false
      t.string :url, null: false
      t.string :information_url, null: false
      t.string :shortener_url
      t.string :shortener_information_url
      t.text :description
      t.datetime :start_at, null: false
      t.datetime :end_at
      t.datetime :activate_start_at, null: false
      t.datetime :activate_end_at
      t.float :min_cost, null: false, default: 0
      t.float :max_cost, null: false, default: 0
      t.string :cost_currency_unit, null: false, default: "円"
      t.string :departure_place
      t.string :destination_place
      t.float :departure_place_lat
      t.float :departure_place_lon
      t.float :destination_place_lat
      t.float :destination_place_lon
      t.timestamps
    end
    add_index :campaigns, [:campaign_id, :type], unique: true
    add_index :campaigns, :url
    add_index :campaigns, :information_url
  end
end
