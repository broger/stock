class Localidad < ActiveRecord::Base
	belongs_to :provincia


    validates_presence_of :nombre, :message => 'es obligatorio.'

  cattr_reader :per_page
  @@per_page = 30

end
