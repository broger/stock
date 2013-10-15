class Comprobante < ActiveRecord::Base
	has_many   :movimientos
	has_many   :users
	belongs_to :tipo_comprobante
	belongs_to :proveedor
	belongs_to :deposito
	belongs_to :cliente
	belongs_to :tipo_pago
	belongs_to :comprobante

	named_scope :pedido_compra, :conditions => { :tipo_comprobante_id =>1 } 
	named_scope :compra,        :conditions => { :tipo_comprobante_id =>2 } 
	named_scope :venta,         :conditions => { :tipo_comprobante_id =>3 } 
	



end
