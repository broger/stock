class TipoComprobante < ActiveRecord::Base
	has_many :comprobantes
	belongs_to :estado
	

end
