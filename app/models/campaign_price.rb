# == Schema Information
#
# Table name: campaign_prices
#
#  id                :bigint(8)        not null, primary key
#  campaign_id       :integer          not null
#  min_price         :float(24)        default(0.0), not null
#  currency_name     :string(255)      default("JPY"), not null
#  departure_place   :string(255)
#  destination_place :string(255)
#
# Indexes
#
#  index_campaign_prices_on_campaign_id  (campaign_id)
#

class CampaignPrice < ApplicationRecord
end
