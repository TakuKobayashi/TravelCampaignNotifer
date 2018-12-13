# == Schema Information
#
# Table name: campaigns
#
#  id                        :bigint(8)        not null, primary key
#  campaign_id               :string(255)
#  type                      :string(255)
#  title                     :string(255)      not null
#  url                       :string(255)      not null
#  information_url           :string(255)      not null
#  shortener_url             :string(255)
#  shortener_information_url :string(255)
#  description               :text(65535)
#  start_at                  :datetime         not null
#  end_at                    :datetime
#  activate_start_at         :datetime         not null
#  activate_end_at           :datetime
#  min_cost                  :float(24)        default(0.0), not null
#  max_cost                  :float(24)        default(0.0), not null
#  cost_currency_unit        :string(255)      default("円"), not null
#  departure_place           :string(255)
#  destination_place         :string(255)
#  condition                 :text(65535)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
# Indexes
#
#  index_campaigns_on_campaign_id_and_type  (campaign_id,type) UNIQUE
#  index_campaigns_on_information_url       (information_url)
#  index_campaigns_on_url                   (url)
#

class Campaign < ApplicationRecord
  BITLY_API_ROOT_URL = "https://api-ssl.bitly.com/v4/"

  before_save do
    if self.url.size > 255
      shorted_url = self.get_short_url
      self.url = shorted_url
      self.shortener_url = shorted_url
    end
  end

  def self.import_campaigns!
  end

  def short_url
    if shortener_url.blank?
      convert_to_short_url!
    end
    return self.shortener_url
  end

  def convert_to_short_url!
    update!(shortener_url: self.get_short_url)
  end

  def get_short_url
    shorted_url = RequestParser.request_and_parse_json(
      url: BITLY_API_ROOT_URL + "shorten",
      method: :post,
      header: {"Authorization" => "Bearer ACCESS_TOKEN", "Content-Type" => "application/json"},
      param: {"long_url" => self.url}
    )
    return shorted_url["link"]
  end
end
