class CreateTravelMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :travel_media do |t|
      t.string :type
      t.string :title, null: false
      t.string :host_url, null: false
      t.string :target_url, null: false
      t.integer :heartbeat_state, null: false, default: 0
      t.datetime :last_heartbeated_at, null: false
      t.text :options
    end
    add_index :travel_media, :target_url, unique: true
  end
end
