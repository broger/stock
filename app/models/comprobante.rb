class Comprobante < ActiveRecord::Base
	has_many :movimientos
	has_many :users
	belongs_to :tipo_comprobante

	named_scope :compras, :conditions => { :tipo_comprobante_id =>1 }



end
