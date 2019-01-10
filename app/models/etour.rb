# == Schema Information
#
# Table name: travel_media
#
#  id                  :bigint(8)        not null, primary key
#  type                :string(255)
#  title               :string(255)      not null
#  host_url            :string(255)      not null
#  target_url          :string(255)      not null
#  heartbeat_state     :integer          default(0), not null
#  last_heartbeated_at :datetime         not null
#  options             :text(65535)
#
# Indexes
#
#  index_travel_media_on_target_url  (target_url) UNIQUE
#

class Etour < TravelMedium
  CRAWL_ROOT_URL = "https://www.etour.co.jp/cmp/allyear/"
end
