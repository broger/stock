class Estado < ActiveRecord::Base
	has_many :productos
	has_many :tipo_comprobantes
	

end
