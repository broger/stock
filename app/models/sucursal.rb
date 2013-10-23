class Sucursal < ActiveRecord::Base
	has_many    :users
	has_one     :deposito
	belongs_to  :lista_precio


end
