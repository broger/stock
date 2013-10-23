class CreateDepositos < ActiveRecord::Migration
  def self.up
    create_table :depositos do |t|
      t.column  :nombre, "character(40)"
      t.integer :localidad_id
      t.integer :provincia_id
      t.column  :direccion, "character(60)"
      t.column  :telefono, "character(30)"
      t.integer :sucursal_id
     
      t.timestamps
    end
  end

  def self.down
    drop_table :depositos
  end
end
