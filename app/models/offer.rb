class Offer < ActiveRecord::Base

  validates :link, :uniqueness => true
  validates :link, :summary, :presence => true

  acts_as_voteable

  has_many :comments

  validates :link, :title, :description, :summary, :screenshot_file_name, :presence => true

  validates :link, :uniqueness => true

  validates_format_of :link, :with => URI::regexp(%w(http https))  

  # Paperclip
  has_attached_file :screenshot,
    :styles => {
      :thumb=> "200x200#",
      :small  => "300x300>" }

  before_create do |offer| 

    require 'process_offer'
    require 'iconv'
    require 'screenchot'

    # process information
    if offer.link.include?("www.infojobs.net")
      result = process_offer("infojobs", offer.link)
      offer.title = result["title"]
      offer.description = result["description"]
    end

    # process the screenshot
    title = Iconv.new('ascii//translit', 'utf-8').iconv(result["title"])
    filename = "/tmp/" + title.gsub(/\s+/, "") + ".png"
    screenchot(link, filename)
    offer.screenshot = File.new(filename)

  end

end
