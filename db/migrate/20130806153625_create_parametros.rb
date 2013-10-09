class CreateParametros < ActiveRecord::Migration
  def self.up
    create_table :parametros do |t|
      t.integer :iva
      t.integer :descuento
      t.column  :nombre_empresa, "character(100)"
      t.column  :direccion, "character(150)"
      t.column  :telefono1, "character(50)"
      t.column  :telefono2, "character(50)"
      t.column  :celular1, "character(50)"
      t.column  :celular2, "character(50)"
      t.integer :localidad_id
      t.integer :provincia_id
      t.integer :moneda_id
      t.column  :cuil, "numeric(12)"


      t.timestamps
    end
  end

  def self.down
    drop_table :parametros
  end
end
