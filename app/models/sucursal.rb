class Sucursal < ActiveRecord::Base
	has_many    :users
	has_one     :deposito
	has_many    :comprobantes
	belongs_to  :lista_precio


end
