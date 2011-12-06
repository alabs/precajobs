class ValidatorController < ApplicationController

  require 'open-uri'
  
  # GET /validator/url?to_verify=http://google.es/
  # GET /validator/url?to_verify=http://google.es/inexistent-url
  def url()

    # are you sure it's an URL?
    url = URI.parse(params[:to_verify])

    # are you sure it exists?
    begin 
      open(url)
      response = "OK"
    rescue
      response = false
    end

    # are you sure we haven't already have it?
    if Offer.find(:all, :conditions => {:link => params[:to_verify]}).any?
      response = "haveit"
    else
      response = "OK"
    end

    render :json => {"status" => response}

  end

end
