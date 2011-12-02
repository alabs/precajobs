require 'open-uri'

def process_offer(link)
  # TOOD: case for link in infojobs, monster, infolancer
  # TODO: return false for link domain unknown
  html = Nokogiri::HTML(open(link).read)
  title = html.xpath('//h1').text.strip
  description = html.xpath('//td[@id="prefijoDescripcion1"]').text
  return { 'title' => title, 'description' => description }
end
