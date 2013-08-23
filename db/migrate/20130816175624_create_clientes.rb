class CreateClientes < ActiveRecord::Migration
  def self.up
    create_table :clientes do |t|
      t.column  :nombre, "character(60)"
      t.column  :cuil, "numeric(12)"
	  t.integer :provincia_id
	  t.integer :localidad_id
      t.column  :direccion, "character(80)"
	  t.integer :banco_id
	  t.column  :cuenta_bacaria, "numeric(30)"
      t.column  :telefono, "numeric(30)"
      t.column  :celular, "numeric(30)"
      t.column  :email, "character(60)"
      t.integer :estado_id
      t.timestamps
    end
  end

  def self.down
    drop_table :clientes
  end
end