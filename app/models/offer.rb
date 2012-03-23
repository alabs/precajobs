class Offer < ActiveRecord::Base

  validates :link, :uniqueness => true
  validates :link, :presence => true

  acts_as_voteable

  has_many :comments

#  validates :link, :title, :description, :summary, :screenshot_file_name, :presence => true

  validates :link, :uniqueness => true

  validates_format_of :link, :with => URI::regexp(%w(http https))  

  # Paperclip
  has_attached_file :screenshot,
    :styles => {
      :thumb=> "200x200#",
      :small  => "300x300>" }

  before_create do |offer| 
    # process information
    crawl_link offer
  end  
   
  after_create do |offer|
    # process the screenshot
    Resque.enqueue(ScreenchotCrawler, offer.id)
  end

  private
    
    def crawl_link(offer)
      require 'process_offer'

      logger.debug "Processing link information ..."
      if offer.link.include?("www.infojobs.net")
        logger.debug "Oh! It's infojobs! We're going to crawl the fucker!"
        result = process_offer("infojobs", offer.link)
        # FIXME: this is stupid. We should do an array and each all this shit
        offer.title = result["title"]
        offer.description = result["description"]
        offer.studies = result["studies"]
        offer.province = result["province"]
        offer.experience = result["experience"]
        offer.requisites_min = result["requisites_min"]
        offer.requisites_des = result["requisites_des"]
        offer.contract_type = result["contract_type"]
        offer.contract_duration = result["contract_duration"]
        offer.contract_hour = result["contract_hour"]
        offer.salary = result["salary"]
      end
    end

end
