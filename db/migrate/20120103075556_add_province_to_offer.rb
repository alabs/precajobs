class AddProvinceToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :province, :string
  end
end
