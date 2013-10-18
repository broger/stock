class Deposito < ActiveRecord::Base
	has_many   :comprobantes
	has_many   :producto_stocks
	belongs_to :sucursal
	
    validates_presence_of :nombre, :message => 'es obligatorio.'

  cattr_reader :per_page
  @@per_page = 30

end
