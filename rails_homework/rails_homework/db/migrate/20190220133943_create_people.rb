class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :name, presence: true
      t.integer :house_id, presence: true 
      t.timestamps
    end
  end
end
