module VotesHelper

  def get_real_ip
    # Devuelve la direccion IP real si nos encontramos detras de uno o varios proxies
    # request.env["HTTP_X_FORWARDED_FOR"]
    x_forward = request.env["HTTP_X_FORWARDED_FOR"]
    x_forward ? x_forward.split(',')[0] : request.remote_ip 
  end

  def has_voted(offer)
    # Comprueba que la oferta que hayamos seleccionado no hayamos votado anteriormente
    offer.votes.where(:ip_address => get_real_ip).count == 1
  end

end
