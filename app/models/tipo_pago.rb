class TipoPago < ActiveRecord::Base
	has_many :comprobantes
end
