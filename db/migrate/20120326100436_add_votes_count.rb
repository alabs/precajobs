class AddVotesCount < ActiveRecord::Migration
  def up
    add_column :offers, :votes_count, :integer, :default => 0  
      
    Offer.reset_column_information  
    Offer.find_each do |p|  
      Offer.reset_counters p.id, :votes
    end  
  end

  def down
    remove_column :offers, :votes_count  
  end
end
