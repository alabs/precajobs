class ScreenchotCrawler
  require 'screenchot'
  @queue = :screenchots_queue

  def self.perform(offer_id)
    @offer = Offer.find(offer_id)
    title = Time.now.to_i.to_s
    filename = "/tmp/" + title.gsub(/\s+/, "") + ".png"
    screenchot(@offer.link, filename)
    @offer.screenshot = File.new(filename)
    @offer.save
  end

end
