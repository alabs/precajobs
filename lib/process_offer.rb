require 'open-uri'
require 'nokogiri'

def get_by_id(html, id)
  html.xpath('//td[@id="' + id + '"]').text.strip
end

def get_a_by_id(html, id)
  html.xpath('//a[@id="' + id + '"]').text.strip
end

def process_offer(site, url)
  case site
    when "infojobs"
      url = URI.parse(URI.encode(url.strip.sub('https', 'http'))
      html = Nokogiri::HTML(open(url).read)
      result = { 
        'title' => html.xpath('//h1').text.strip, 
        'description' => get_by_id(html, "prefijoDescripcion1"), 
        'province' => get_a_by_id(html, "prefijoProvincia"), 
        'studies' => get_by_id(html, "prefijoEstMin"),
        'experience' => get_by_id(html, "prefijoExpMin"),
        'requisites_min' => get_by_id(html, "prefijoReqMinimos"),
        'requisites_des' => get_by_id(html, "prefijoReqDeseados"),
        'contract_type' => get_by_id(html, "prefijoContrato"),
        'contract_duration' => get_by_id(html, "prefijoDuracion"),
        'contract_hour' => get_by_id(html, "prefijoHorario"),
        'salary' => get_by_id(html, "prefijoSalario")
      }
    else 
      result = false
  end 

  return result

end
