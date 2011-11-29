class AddSummaryToOffer < ActiveRecord::Migration
  def self.up
    add_column :offers, :summary, :text
  end

  def self.down
    remove_column :offers, :summary
  end
end
