class ApplicationController < ActionController::Base
  protect_from_forgery

  def get_real_ip
    # Devuelve la direccion IP real si nos encontramos detras de uno o varios proxies
    request.env["HTTP_X_FORWARDED_FOR"].split(',')[0] || request.remote_ip
  end

end
