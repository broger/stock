class Movimiento < ActiveRecord::Base
	belongs_to  :comprobante
	belongs_to  :producto
	belongs_to  :user
	belongs_to  :deposito
end
