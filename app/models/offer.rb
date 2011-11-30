class Offer < ActiveRecord::Base
  acts_as_voteable

  has_many :comments

  validates :link, :title, :description, :summary, :screenshot_file_name, :presence => true

  validates :link, :uniqueness => true

  validates_format_of :link, :with => URI::regexp(%w(http https))  

  # Paperclip
  has_attached_file :screenshot,
    :styles => {
      :thumb=> "100x100#",
      :small  => "150x150>" 
  }

end
