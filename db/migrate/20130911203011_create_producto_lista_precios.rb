class CreateProductoListaPrecios < ActiveRecord::Migration
  def self.up
    create_table :producto_lista_precios do |t|
      t.integer :producto_id
      t.integer :lista_precio_id
      t.double  :precio, :decimal => 10, :scale => 4
      t.double  :decuento, :decimal =>10, :scale => 4
      t.timestamps
    end
  end

  def self.down
    drop_table :producto_lista_precios
  end
end
