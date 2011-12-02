require 'open-uri'

def process_offer(site, url)
  case site
    when "infojobs"
      url = URI.parse(URI.encode(url.strip))
      html = Nokogiri::HTML(open(url).read)
      title = html.xpath('//h1').text.strip
      description = html.xpath('//td[@id="prefijoDescripcion1"]').text
      result = { 'title' => title, 'description' => description }
    else 
      result = false
  end 

  return result

end
