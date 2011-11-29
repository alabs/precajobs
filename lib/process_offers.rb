require 'open-uri'

link = "http://www.infojobs.net/madrid/teleoperadores-venta-seguros-empresa-lider-sector/of-ia38f78f7494b508a985e7db70c58ba"

html = Nokogiri::HTML(open(link).read)
title = html.xpath('//h1').text.strip
descripcion = html.xpath('//td[@id="prefijoDescripcion1"]').text
