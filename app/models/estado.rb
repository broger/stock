class Estado < ActiveRecord::Base
	has_many :productos
	has_many :tipo_comprobantes
	has_many :clientes
	

end
