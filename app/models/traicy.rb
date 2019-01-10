# == Schema Information
#
# Table name: articles
#
#  id          :bigint(8)        not null, primary key
#  type        :string(255)
#  title       :string(255)      not null
#  basic_src   :string(255)      not null
#  remain_src  :text(65535)
#  crawl_state :integer          default("standby"), not null
#  options     :text(65535)
#
# Indexes
#
#  index_articles_on_basic_src  (basic_src)
#

class Traicy < Article
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
