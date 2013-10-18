class ProductoStock < ActiveRecord::Base

	belongs_to :producto
	belongs_to :deposito



end
