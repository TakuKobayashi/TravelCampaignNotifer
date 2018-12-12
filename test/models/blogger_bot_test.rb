# == Schema Information
#
# Table name: blogger_bots
#
#  id            :bigint(8)        not null, primary key
#  blogger_id    :string(255)      not null
#  title         :string(255)      not null
#  tag_names     :string(255)
#  url           :string(255)      not null
#  campaign_ids  :text(65535)      not null
#  body          :text(16777215)   not null
#  rendered_body :text(16777215)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_blogger_bots_on_blogger_id  (blogger_id) UNIQUE
#

require 'test_helper'

class BloggerBotTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
