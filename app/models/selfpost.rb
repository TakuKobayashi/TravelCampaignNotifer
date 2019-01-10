# == Schema Information
#
# Table name: campaigns
#
#  id                :bigint(8)        not null, primary key
#  campaign_id       :string(255)
#  source_type       :string(255)
#  source_id         :integer
#  type              :string(255)
#  title             :string(255)      not null
#  url               :string(255)      not null
#  shortener_url     :string(255)
#  description       :text(65535)
#  image_url         :text(65535)
#  start_at          :datetime         not null
#  end_at            :datetime
#  limit_amount      :bigint(8)
#  condition_comment :text(65535)      not null
#  options           :text(65535)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_campaigns_on_source_type_and_source_id  (source_type,source_id)
#  index_campaigns_on_start_at_and_end_at        (start_at,end_at)
#  index_campaigns_on_url                        (url) UNIQUE
#

class Selfpost < Campaign
end
