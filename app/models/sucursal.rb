class Sucursal < ActiveRecord::Base
	has_many :users
	has_one :deposito


end
