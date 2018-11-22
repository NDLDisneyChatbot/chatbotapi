class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :mobile
      t.float :longitude
      t.float :latitude
      t.integer :status

      t.timestamps
    end
  end
end
