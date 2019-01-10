class WebsiteBase < ApplicationRecord
  self.abstract_class = true

  def src
    return URI.escape(self.basic_src.to_s + self.remain_src.to_s)
  end

  def src=(url)
    aurl = Addressable::URI.parse(url)
    self.basic_src = aurl.origin.to_s + aurl.path.to_s
    if aurl.query.present?
      self.remain_src = "?" + aurl.query.to_s
    else
      self.remain_src = ""
    end
  end

  def self.import_websites!(websites:)
    src_websites = self.where(basic_src: websites.map(&:basic_src).uniq).index_by(&:src)
    import_websites = websites.select{|imp| src_websites[imp.src].blank? }.uniq(&:src)
    if import_websites.present?
      self.import!(import_websites)
    end
  end
end