class Vote < ActiveRecord::Base

  belongs_to :offer, :counter_cache => true

  @ip_regex = /^([1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$/

  validates :ip_address, 
          :presence => true, 
          :format => { :with => @ip_regex } 

  validates :offer_id, :uniqueness => {:scope => :ip_address}

  def self.has_voted
    self.where(:offer_id => offer)
  end
end
