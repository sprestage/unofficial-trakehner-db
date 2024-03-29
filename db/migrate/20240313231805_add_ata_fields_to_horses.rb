class AddAtaFieldsToHorses < ActiveRecord::Migration[7.0]
  def change
    add_column :horses, :registration_number, :string
    add_column :horses, :gender, :string
    add_column :horses, :color, :string
    add_column :horses, :birth_year, :integer
    add_column :horses, :breeder_id, :integer
    add_column :horses, :performance_records_available, :boolean
  end
end
