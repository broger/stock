class CreateProductos < ActiveRecord::Migration
  def self.up
    create_table :productos do |t|

      t.column  :nombre, "character(60)"
      t.string  :descripcion
  	  t.integer :marca_id
	    t.integer :unidad_id
	    
      t.integer :rubro_id
      t.integer :seccion_id
      t.integer :categoria_id

      t.integer :provedor_id
	    t.integer :codigo_proveedor
   	  t.integer :proveedor2_id

	    t.double  :stock, :decimal => 7, :scale => 2
      t.integer :stock_minimo
	    t.boolean :avisa_stock_minimo
      t.boolean :visible_web

      t.double  :costo, :decimal => 7, :scale => 2
      t.double  :ganancia, :decimal=> 7, :scale => 2
      t.double  :descuento_contado, :decimal => 7, :scale => 2
      t.double  :iva, :decimal => 7, :scale => 2
	    t.integer :moneda_id

	    t.integer :deposito_id

   	  t.integer :estado_id

        	
      t.timestamps

    end
  end

  def self.down
    drop_table :productos
  end
end
