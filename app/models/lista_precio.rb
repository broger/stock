class ListaPrecio < ActiveRecord::Base

	has_many :producto_lista_precios
	has_many :sucursales

end
