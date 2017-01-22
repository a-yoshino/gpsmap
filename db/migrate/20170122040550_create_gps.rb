class CreateGps < ActiveRecord::Migration
  def change
    create_table :gps do |t|
      t.float :lat
      t.float :lon

      t.timestamps
    end
  end
end
