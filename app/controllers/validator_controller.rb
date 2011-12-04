class ValidatorController < ApplicationController

  require 'open-uri'
  
  # GET /validator/url?to_verify=http://google.es/
  # GET /validator/url?to_verify=http://google.es/inexistent-url
  def url()

    url = URI.parse(params[:to_verify])

    begin 
      open(url)
      response = true
    rescue
      response = false
    end

    render :json => {"status" => response}

  end

end
