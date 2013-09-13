class CreateComprobantes < ActiveRecord::Migration
  def self.up
    create_table :comprobantes do |t|
      t.integer  :tipo_comprobante_id
      t.column   :numero,     "numeric(16)"
      t.column   :total,   "numeric(8,4)"

      #Compras
      t.boolean  :aprobado
      t.integer  :proovedor_id

      #Ventas
      t.integer  :proovedor_id
      t.integer  :forma_pago_id
      t.column   :nro_tarjeta

      #varios
      t.integer  :usuario_id
      t.integer  :vendedor_id
	  t.string   :comentarios


	  #ANULACION
	  t.boolean  :anulada
      t.date     :fecha_anulacion
      

      t.timestamps
    end
  end

  def self.down
    drop_table :comprobantes
  end
end
