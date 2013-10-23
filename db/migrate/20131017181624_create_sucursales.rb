class CreateSucursales < ActiveRecord::Migration
  def self.up
    create_table :sucursales do |t|
      t.string  :nombre
      t.string  :telefono
      t.string  :mail
      t.integer :provincia_id
      t.integer :localidad_id
      t.string  :direccion
      t.integer :lista_precio_id
      t.column  :abrev, "character(10)"

      t.timestamps
    end
  end

  def self.down
    drop_table :sucursales
  end
end
