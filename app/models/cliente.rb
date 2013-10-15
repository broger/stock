class Cliente < ActiveRecord::Base
	belongs_to :estado
	belongs_to :provincia
	belongs_to :localidad
	has_many   :comprobantes

end
