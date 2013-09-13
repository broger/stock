class CreateTipoComprobantes < ActiveRecord::Migration
  def self.up
    create_table :tipo_comprobantes do |t|

      t.column   :ultimo_nro,     "numeric(10)"
	  t.string   :nombre

      t.boolean  :registra_nro
      t.column   :ultimo_nro,     "numeric(16)"

      t.boolean  :afecta_stock
      
      t.timestamps
    end
  end

  def self.down
    drop_table :tipo_comprobantes
  end
end
