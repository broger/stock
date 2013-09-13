class CreateMovimientos < ActiveRecord::Migration
  def self.up
    create_table :movimientos do |t|
      t.integer  :producto_id
      t.column   :cantidad,     "numeric(8,4)"
      t.boolean  :afecta_stock
      t.integer  :deposito_id
     
      t.integer :comprobante_id 

      t.integer  :usuario_id
      t.string   :comentarios

      t.column   :costo,        "numeric(8,4)"
	  t.column   :ganancia,     "numeric(8,4)"
	  t.column   :iva,          "numeric(8,4)"
	  t.column   :descuento,    "numneric(8,4)" 
	  t.column   :precio_total, "numneric(8,4)" 

 
      t.timestamps
    end
  end

  def self.down
    drop_table :movimientos
  end
end
