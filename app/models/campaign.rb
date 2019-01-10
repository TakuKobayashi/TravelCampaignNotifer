# == Schema Information
#
# Table name: campaigns
#
#  id                 :bigint(8)        not null, primary key
#  group_uuid         :string(255)      not null
#  campaign_id        :string(255)
#  source_type        :string(255)
#  source_id          :integer
#  type               :string(255)
#  title              :string(255)      not null
#  url                :string(255)      not null
#  shortener_url      :string(255)
#  description        :text(65535)
#  image_url          :text(65535)
#  start_at           :datetime         not null
#  end_at             :datetime
#  limit_amount       :bigint(8)
#  min_cost           :float(24)        default(0.0), not null
#  max_cost           :float(24)        default(0.0), not null
#  cost_currency_unit :string(255)      default("円"), not null
#  departure_place    :string(255)
#  destination_place  :string(255)
#  options            :text(65535)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_campaigns_on_group_uuid                 (group_uuid)
#  index_campaigns_on_source_type_and_source_id  (source_type,source_id)
#  index_campaigns_on_start_at_and_end_at        (start_at,end_at)
#  index_campaigns_on_url                        (url) UNIQUE
#

class Campaign < ApplicationRecord
  serialize :options, JSON

  belongs_to :source, polymorphic: true, required: false

  BITLY_API_ROOT_URL = "https://api-ssl.bitly.com/v4/"

  before_save do
    if self.url.size > 255
      shorted_url = self.get_short_url
      self.url = shorted_url
      self.shortener_url = shorted_url
    end
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
