class RemoveSummaryFromOffer < ActiveRecord::Migration
  def up
    remove_column :offers, :summary
  end

  def down
    add_column :offers, :summary, :text
  end
end
