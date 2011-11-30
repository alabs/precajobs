class Offer < ActiveRecord::Base
  acts_as_voteable

  has_many :comments

  # Paperclip
  has_attached_file :screenshot,
    :styles => {
      :thumb=> "100x100#",
      :small  => "150x150>" }
end
