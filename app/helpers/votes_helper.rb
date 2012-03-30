module VotesHelper

  def has_voted(offer)
    # Comprueba que la oferta que hayamos seleccionado no hayamos votado anteriormente
    offer.votes.where(:ip_address => get_real_ip).count == 1
  end

end
