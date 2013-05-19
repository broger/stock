class CreateProveedores < ActiveRecord::Migration
  def self.up
    create_table :proveedores do |t|
      t.column  :nombre, "character(60)"
      t.column  :razon_social, "character(60)"
      t.column  :cuil, "numeric(12)"
	    t.integer :provincia_id
	    t.integer :localidad_id
      t.column  :direccion, "character(80)"
	    t.integer :banco_id
	    t.column  :cuenta_bacaria, "numeric(30)"
      t.column  :telefono1, "numeric(30)"
      t.column  :telefono2, "numeric(30)"
      t.column  :celular1, "numeric(30)"
      t.column  :celular2, "numeric(30)"
      t.column  :email, "character(60)"
      t.column  :web, "character(60)"
	  t.integer :estado_id	
      t.timestamps
    end
  end

  def self.down
    drop_table :proveedores
  end
end
