module WebNormalizer
  def self.merge_full_url(src:, org:)
    src_url = Addressable::URI.parse(src.to_s.gsub(/(\.\.\/|\.\/)+/,"/"))
    org_url = Addressable::URI.parse(org.to_s)
    pathes = src_url.path.to_s.split("/")
    # #記号のあとにあるものは
    # 空っぽもありうる
    if pathes.last.try(:include?, "#")
      pathes[pathes.size - 1] = pathes.last.gsub(/#.*/, "")
      src_url.path = pathes.join("/")
    end
    if (src_url.scheme.blank? || src_url.host.blank?)
      if src_url.path.to_s.first != "/"
        org_pathes = org_url.path.to_s.split("/")
        new_pathes = org_pathes[0..(org_pathes.size - 2)] + pathes
        src_url.path = new_pathes.join("/")
      end
    end
    if src_url.scheme.blank?
      src_url.scheme = org_url.scheme.to_s
    end
    if src_url.host.blank?
      src_url.host = org_url.host.to_s
    end
    return src_url
  end

  def self.url_partition(url:)
    aurl = Addressable::URI.parse(url)
    pure_url = URI.unescape(aurl.origin.to_s + aurl.path.to_s)
    if pure_url.size > 255
      word_counter = 0
      srces, other_pathes = pure_url.split("/").partition do |word|
        word_counter = word_counter + word.size + 1
        word_counter <= 255
      end
      basic_src = srces.join("/")
      remain_src = "/" + other_pathes.join("/")
    else
      basic_src = pure_url
      remain_src = ""
    end
    if aurl.query.present?
      remain_src += "?" + aurl.query
    end
    return basic_src, URI.unescape(remain_src)
  end

  def self.get_final_location_url(url:)
    http = HTTPClient.new
    response = http.get(url)
    if response.redirect?
      new_url = response.header["location"].first
      if response.status == 307
        return new_url
      elsif response.status >= 300 && response.status < 400
        return self.get_final_location_url(url: new_url)
      else
        return url
      end
    else
      return url
    end
  end

  def self.is_same_host?(main_url:, check_url:)
    check_full_url = self.merge_full_url(src: check_url, org: main_url)
    amain_url = Addressable::URI.parse(main_url.to_s)
    acheck_url = Addressable::URI.parse(check_full_url.to_s)
    if amain_url.host != acheck_url.host
      return false
    end
    final_url = self.get_final_location_url(url: check_url)
    afinal_url = Addressable::URI.parse(final_url.to_s)
    return amain_url.host == afinal_url.host
  end
end