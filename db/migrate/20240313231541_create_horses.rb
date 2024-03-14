class CreateHorses < ActiveRecord::Migration[7.0]
  def change
    create_table :horses do |t|
      t.string :name
      t.integer :dam_id
      t.integer :sire_id
      t.string :thumbnail
      t.string :image

      t.timestamps
    end
  end
end
