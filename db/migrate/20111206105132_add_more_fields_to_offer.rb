class AddMoreFieldsToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :studies, :string
    add_column :offers, :experience, :string
    add_column :offers, :requisites_min, :string
    add_column :offers, :requisites_des, :string
    add_column :offers, :contract_type, :string
    add_column :offers, :contract_duration, :string
    add_column :offers, :contract_hour, :string
    add_column :offers, :salary, :string
  end
end
