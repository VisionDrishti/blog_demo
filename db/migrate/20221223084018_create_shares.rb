class CreateShares < ActiveRecord::Migration[7.0]
  def change
    create_table :shares do |t|

      t.timestamps
    end
  end
end
