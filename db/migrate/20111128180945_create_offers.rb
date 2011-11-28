class CreateOffers < ActiveRecord::Migration
  def self.up
    create_table :offers do |t|
      t.string :link
      t.string :title
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :offers
  end
end
