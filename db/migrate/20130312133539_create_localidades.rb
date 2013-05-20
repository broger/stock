class CreateLocalidades < ActiveRecord::Migration
  def self.up
    create_table :localidades do |t|
      t.string :nombre
      t.integer :provincia_id
	  t.integer :codigo_postal

      t.timestamps
    end
  end

  def self.down
    drop_table :localidads
  end
end
