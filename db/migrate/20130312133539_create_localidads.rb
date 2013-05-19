class CreateLocalidads < ActiveRecord::Migration
  def self.up
    create_table :localidads do |t|
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
