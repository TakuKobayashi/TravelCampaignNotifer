# == Schema Information
#
# Table name: travel_websites
#
#  id                  :bigint(8)        not null, primary key
#  title               :string(255)      not null
#  host_url            :string(255)      not null
#  target_url          :string(255)      not null
#  heartbeat_state     :integer          default(0), not null
#  last_heartbeated_at :datetime         not null
#  options             :text(65535)
#
# Indexes
#
#  index_travel_websites_on_host_url  (host_url) UNIQUE
#

require 'test_helper'

class TravelWebsiteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
