class CreateProductos < ActiveRecord::Migration
  def self.up
    create_table :productos do |t|

      t.column  :codigo, "character(8)"
      t.column  :nombre, "character(60)"
      t.column  :etiqueta_busqueda, "character(30)"
      t.string  :descripcion
  	  t.integer :marca_id
	    t.integer :unidad_id
	    
      t.integer :rubro_id
      t.integer :seccion_id
      t.integer :categoria_id

      t.integer :provedor_id
	    t.integer :codigo_proveedor

      t.double  :stock_minimo, :decimal => 7, :scale => 4
      t.double  :stock_ideal, :decimal => 7, :scale => 4
      t.double  :punto_pedido, :decimal => 7, :scale => 4
      

      t.boolean :visible_web
      t.column  :calificacion, "character(1)"

      t.double  :costo, :decimal => 7, :scale => 2
      t.double  :ganancia, :decimal=> 7, :scale => 2
      t.double  :descuento_contado, :decimal => 7, :scale => 2
      t.double  :iva, :decimal => 7, :scale => 2

   	  t.integer :estado_id

        	
      t.timestamps

    end
  end

  def self.down
    drop_table :productos
  end
end
