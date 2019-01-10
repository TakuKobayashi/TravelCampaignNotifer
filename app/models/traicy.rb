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

class Traicy < Article
  CRAWL_ROOT_URL = "https://www.traicy.com/sale"

  def self.import_all_page!
    page = 1
    loop do
      results = self.crawl_and_import!(page: page)
      break if results.blank?
      page = page + 1
      sleep 1
    end
  end

  def self.crawl_and_import!(page: 1)
    crawl_url = CRAWL_ROOT_URL
    if page > 1
      crawl_url += "/page/" + page.to_s
    end
    html_dom = RequestParser.request_and_parse_normalize_html(url: crawl_url)
    article_doms = html_dom.css("#article-card-content-archive")
    articles = []
    article_doms.each do |article_dom|
      url_dom = article_dom.css("a")
      img_dom = article_dom.css("img")
      if url_dom.first.present? && img_dom.first.present?
        article = Traicy.new(title: article_dom.text.strip)
        article.src = url_dom.first[:href]
        article.image_url = img_dom.first[:src]
        articles << article
      end
    end
    self.import_websites!(websites: articles)
    return articles
  end
end
