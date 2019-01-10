# == Schema Information
#
# Table name: campaigns
#
#  id                        :bigint(8)        not null, primary key
#  campaign_id               :string(255)
#  travel_website_id         :integer
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
#  limit_amount              :bigint(8)
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

class Traicy < Campaign
  CRAWL_ROOT_URL = "https://www.traicy.com/sale"

  def self.crawl_and_import!
    html_dom = RequestParser.request_and_parse_normalize_html(url: CRAWL_ROOT_URL + "/page/" )
    article_doms = html_dom.css("#article-card-content-archive")
    article_links = article_doms.map do |article_dom|
      url_dom = article_dom.css("a").first
      if url_dom.present?
        url_dom[:href]
      else
        nil
      end
    end.compact
  end
end
