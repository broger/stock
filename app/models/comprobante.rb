class Comprobante < ActiveRecord::Base
	has_many   :movimientos
	has_many   :users
	belongs_to :tipo_comprobante
	belongs_to :proveedor
	belongs_to :deposito

	named_scope :compra,        :conditions => { :tipo_comprobante_id =>1 } # COMPRAS
	named_scope :pedido_compra, :conditions => { :tipo_comprobante_id =>2 } # PEDIDO COMPRAS



end
