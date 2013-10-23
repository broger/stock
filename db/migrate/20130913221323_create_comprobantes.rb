class CreateComprobantes < ActiveRecord::Migration
  def self.up
    create_table :comprobantes do |t|
      t.integer  :tipo_comprobante_id
      t.column   :numero, "numeric(16)"
      t.integer  :comprobante_id
      t.integer  :sucursal_id
      t.integer  :usuario_id
      t.integer  :vendedor_id
      t.string   :observaciones
      t.column   :total,   "numeric(10)"
      
      # compras
      t.boolean  :aprobado
      t.integer  :proveedor_id
      t.boolean  :enviado_proveedor
      t.date     :fecha_envio
      t.column   :costos, "numeric(10,4)"
      
      # ventas
      t.integer  :forma_pago_id
      t.column   :nro_tarjeta
      t.integer  :cliente_id

      
    end
  end

  def self.down
    drop_table :comprobantes
  end
end
