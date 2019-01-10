# == Schema Information
#
# Table name: articles
#
#  id          :bigint(8)        not null, primary key
#  type        :string(255)
#  title       :string(255)      not null
#  basic_src   :string(255)      not null
#  remain_src  :text(65535)
#  image_url   :text(65535)
#  crawl_state :integer          default("standby"), not null
#  options     :text(65535)
#
# Indexes
#
#  index_articles_on_basic_src  (basic_src)
#

class Helppoint < Article
  CRAWL_ROOT_URL = "http://helppointuk.blogspot.com/"
end
