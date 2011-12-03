class Offer < ActiveRecord::Base
  acts_as_voteable

  # Paperclip
  has_attached_file :screenshot,
    :styles => {
      :thumb=> "200x200#",
      :small  => "300x300>" }
end
