class CreateVotes < ActiveRecord::Migration
  def change
    drop_table :votes

    create_table :votes do |t|
      t.string :ip_address
      t.integer :offer_id

      t.timestamps
    end
  end
end
