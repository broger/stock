class CreateProductoListaPrecios < ActiveRecord::Migration
  def self.up
    create_table :producto_lista_precios do |t|
      t.integer :producto_id
      t.integer :lista_precio_id
      t.column  :precio,     "numeric(8,2)"
      t.column  :descuento,  "numeric(8,2)"
      
      t.timestamps
    end
  end

  def self.down
    drop_table :producto_lista_precios
  end
end
