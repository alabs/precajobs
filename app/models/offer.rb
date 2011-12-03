class Offer < ActiveRecord::Base

  require 'process_offer'
  require 'screenchot'

  acts_as_voteable

  # Paperclip
  has_attached_file :screenshot,
    :styles => {
      :thumb=> "200x200#",
      :small  => "300x300>" }

  before_create do |offer| 

    # process information
    if offer.link.include?("www.infojobs.net")
      result = process_offer("infojobs", offer.link)
      offer.title = result["title"]
      offer.description = result["description"]
    end

    # process the screenshot
    filename = "/tmp/" + result["title"].gsub(/\s+/, "") + ".png"
    screenchot(link, filename)
    offer.screenshot = File.new(filename)

  end

end
