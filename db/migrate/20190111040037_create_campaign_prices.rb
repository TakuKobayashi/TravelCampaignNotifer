class CreateCampaignPrices < ActiveRecord::Migration[5.2]
  def change
    create_table :campaign_prices do |t|
      t.integer :campaign_id, null: false
      t.float :min_price, null: false, default: 0
      t.string :currency_name, null: false, default: "JPY"
      t.string :departure_place
      t.string :destination_place
    end

    add_index :campaign_prices, :campaign_id
  end
end
